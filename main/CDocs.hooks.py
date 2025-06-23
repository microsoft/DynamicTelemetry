from __future__ import annotations

import re
import random
import os
from urllib.parse import quote
from pathlib import Path
from typing import TYPE_CHECKING
import mkdocs.plugins
import CDocs_utils as CDocs
from sanitycheck_helpers import sanitycheck

def ends_with_newline(file_path):
    with open(file_path, 'rb') as file:
        file.seek(-1, 2)  # Move the cursor to the last byte of the file
        last_char = file.read(1)
        return last_char == b'\n'

def filter_bytes(file_path):
    with open(file_path, 'rb') as file:
        data = file.read()
    filtered_data = bytes(byte for byte in data if byte <= 127)

    return filtered_data

@mkdocs.plugins.event_priority(50000)
def on_page_markdown(markdown: str, page: Page, config: MkDocsConfig, **kwargs) -> str | None:

    #if not "status" in page.meta:
    #    raise Exception("Please Set Status in " + page.file.src_path)

    #if not "author" in page.meta:
    #    raise Exception("Please Set Author in " + page.file.src_path)

    file = "./docs/" + page.file.src_path
    if 0 != sanitycheck(file):
        #
        # BUGBUG : keep this file rewrite here until we're sure where these
        #          extended characters are coming from (pandoc)
        #
        #filtered_data = filter_bytes(file)
        #with open(file, 'wb') as out_file:
        #    out_file.write(filtered_data)
        raise Exception("Sanity Check failed for " + file)


    data = ""
    if -1 == markdown.find("ProvideFeedback"):
        encoded = quote(page.file.src_path)

        ret = ""
        ret += "??? danger \"Dynamic Telemetry is a PROPOSAL : please provide feedback! :-)\"\n"
        ret += "    Dynamic Telemetry is not an implementation, it's a request for collaboration, \n"
        ret += "    that will lead to an shared understanding, and hopefully one or more implementations.\n"
        ret += "\n\n"
        ret += "    Your feedback and suggestions on this document are highly encouraged!\n\n"
        ret += "    *Please:*\n\n"
        ret += "    1. [Join us, by providing comments or feedback, in our Discussions page](https://github.com/microsoft/DynamicTelemetry/discussions)\n\n"
        ret += "    1. Submit a PR with changes to this file ( **" + page.file.src_path + "**)\n\n"
        ret += "\n\n"
        ret += "\n\n"
        ret += "    *Direct Sharing URL*\n\n"
        ret += "    ```cdocs\n"
        ret += "    http://microsoft.github.io/DynamicTelemetry/" + page.file.url + "\n"
        ret += "    ```\n\n"
        ret += "\n\n"

        data += ret
        data += CDocs.RemoveImageWithAndHeightInfo(markdown)
    else:
        data += CDocs.RemoveImageWithAndHeightInfo(markdown)


    return data
