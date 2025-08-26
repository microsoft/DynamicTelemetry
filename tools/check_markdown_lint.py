#!/usr/bin/env python3

import json
import subprocess
import sys

from pathlib import Path
from typing import List, Dict

def find_markdown_files(base_path: str) -> List[Path]:
    """Recursively find all markdown files in the given directory."""
    base = Path(base_path)
    return list(base.rglob("*.md"))

def check_markdown_file(file_path: str, config_path: str) -> bool:
    """Check a markdown file against markdownlint rules. Returns True if file is compliant."""

    # Run markdownlint-cli with JSON output format
    result = subprocess.run(
        ["markdownlint", "-c", config_path, file_path],
        text=True
    )

    # If return code is 0, file is compliant
    return result.returncode == 0

def main():
    # Set paths
    repo_root = Path(__file__).parent.parent
    config_path = repo_root / ".markdownlint.yaml"
    docs_path = repo_root / "docs"

    # Verify markdownlint-cli is installed
    try:
        subprocess.run(["markdownlint", "--version"], capture_output=True)
    except FileNotFoundError:
        print("Error: markdownlint-cli is not installed.")
        print("Please install it using: npm install -g markdownlint-cli")
        sys.exit(1)

    # Find all markdown files
    md_files = find_markdown_files(docs_path)

    # Track good files and issues
    good_files = []
    files_with_issues = False

    # Check each file
    for md_file in md_files:
        # Skip GeneratedFileStatus.md files
        if md_file.name == "GeneratedFileStatus.md":
            continue

        is_compliant = check_markdown_file(str(md_file), str(config_path))
        if not is_compliant:
            print(f"BAD {md_file}")
            files_with_issues = True
        else:
            good_files.append(md_file)

    if not files_with_issues:
        print("All markdown files conform to the style guide.")
        print("\nCompliant files:")
        for file in good_files:
            print(f"    {file}")
    else:
        sys.exit(1)

if __name__ == "__main__":
    main()
