#!/usr/bin/env python3

import os
import shutil
import datetime
import uuid
from pathlib import Path

def ensure_directory(path):
    """Create directory if it doesn't exist."""
    if not os.path.exists(path):
        os.makedirs(path)

def remove_if_exists(path):
    """Remove file if it exists."""
    if os.path.exists(path):
        os.remove(path)

def create_title_file(bound_docs_path):
    """Create title.txt with metadata."""
    title_path = os.path.join(bound_docs_path, 'title.txt')
    remove_if_exists(title_path)

    current_date = datetime.datetime.now()
    with open(title_path, 'w') as f:
        f.write('---\n')
        f.write(f'title: Dynamic Telemetry {current_date}\n')
        f.write('author: Chris Gray at.al\n')
        f.write(f'date: {current_date}\n')
        f.write('---\n')

def copy_doc_files(source_dir, dest_dir):
    """Copy all documentation files to bound_docs."""
    print(f"\nCopying all doc files into {dest_dir}, for processing\n")
    for item in os.listdir(source_dir):
        source = os.path.join(source_dir, item)
        destination = os.path.join(dest_dir, item)

        if os.path.isdir(source):
            if os.path.exists(destination):
                shutil.rmtree(destination)
            shutil.copytree(source, destination)
        else:
            shutil.copy2(source, destination)
    print("Copy Complete")

def run_pandoc(cmd, dest_file):
    """Run Pandoc"""


    print("")
    print("")
    print("--------------------------------")
    print(f"***PANDOC****")
    print(f"       ARGS: {cmd}")
    print(f"        CWD: {os.getcwd()}")

    if os.system(cmd) != 0:
        msg = f"***Pandoc conversion failed for {cmd}"
        raise RuntimeError(msg)
    #
    if not os.path.exists(dest_file):
        msg = f"***Output file not created: {dest_file}"
        raise RuntimeError(msg)


def process_markdown_files(docs_dir, bound_docs_dir, mkdocs_content):
    """Process markdown files based on navigation markers."""
    in_nav = False
    bind_files = []

    print(f"PROCESS_MARKDOWN_FILES:  {os.getcwd()}")

    for line in mkdocs_content:
        line = line.strip()

        if line == "#<START_BINDING>":
            print("Found NAV")
            in_nav = True
            continue
        elif line == "#<END_BINDING>":
            print("End NAV")
            in_nav = False
            continue

        if not in_nav:
            continue

        # Skip empty lines and comments
        if not line or line.startswith('#'):
            continue

        # Calculate indentation level
        separator_index = line.find('-')
        if separator_index > 4:
            tab_level = (separator_index - 4) // 4 if separator_index % 4 == 0 else 0
            os.environ['CDOCS_TAB'] = str(tab_level)
        os.environ['CDOCS_FILTER'] = '1'

        if not line.endswith('.md'):
            # Generate new section
            title = line.replace('-', '').replace(':', '').strip()
            file_id = str(uuid.uuid4())
            print(f"Generating : [{line}] ==> {title} ==> {file_id}")

            source_file = os.path.join(bound_docs_dir, f"{file_id}.generated.md")
            dest_leaf = f"{file_id}.generated.converted.md"

            with open(source_file, 'w') as f:
                f.write("\\newpage\n")
                f.write(f"# {title}\n")
        else:
            # Process existing markdown file
            #print(f"     LINE : {line}")
            file_path = line.split(':')[1].strip()
            file_path = os.path.join(docs_dir, file_path)

            #print(f" DOCS_DIR : {docs_dir}")
            #print(f"FILE_PATH : {file_path}")

            if not os.path.exists(file_path):
                msg = f"BAD: File doesn't exist: {file_path}"
                raise FileNotFoundError(msg)

            source_file = file_path
            dest_leaf = os.path.basename(file_path)

        # Convert using pandoc
        dest_file = os.path.join(bound_docs_dir, dest_leaf)
        cmd = f'pandoc -i "{source_file}" -o "{dest_file}" --filter CDocsMarkdownCommentRender'

        print("")
        print(f"# Converting {source_file} ==> {dest_leaf}")

        run_pandoc(cmd, dest_file)

        bind_files.append(dest_leaf)

    # Write bind.files
    bind_filename = os.path.join(bound_docs_dir, 'bind.files')
    print(f"*(*(*)*)*)*)* BIND FILE {bind_filename}")
    with open(bind_filename, 'w') as f:
        f.write('\n'.join(bind_files))

def main():
    print("Binding Docs.............")

    # Set error handling to stop on errors
    os.environ['PYTHONUNBUFFERED'] = '1'

    # Change to docs directory
    docs_dir = os.environ.get('DT_DOCS_DIR')
    if not docs_dir:
        raise EnvironmentError("DT_DOCS_DIR environment variable must be set")
    os.chdir(docs_dir)

    # Set up DB directory
    db_dir = os.path.abspath(os.path.join('..', 'orig_media'))
    os.environ['CDOCS_DB'] = db_dir

    print(f">>>>>>DT_DOCS_DIR={docs_dir}")


    # Read mkdocs.yml
    with open('../../mkdocs.yml', 'r') as f:
        mkdocs_content = f.readlines()

    # Set up bound_docs directory
    base_dir = os.path.dirname(docs_dir)
    bound_docs_dir = os.path.join(base_dir, 'bound_docs')
    ensure_directory(bound_docs_dir)

    # Remove existing files
    remove_if_exists(os.path.join(bound_docs_dir, 'bind.files'))

    # Create title file
    create_title_file(bound_docs_dir)

    # Copy documentation files
    copy_doc_files('.', bound_docs_dir)

    try:
        print(f"**CHANGING BASE DIR : {base_dir}")
        os.chdir(docs_dir)
        process_markdown_files(base_dir, bound_docs_dir, mkdocs_content)
    finally:
        os.chdir(base_dir)

if __name__ == '__main__':
    main()
