from __future__ import annotations

import re
import random
import os
from urllib.parse import quote
from pathlib import Path
from typing import TYPE_CHECKING
import mkdocs.plugins
import CDocs_utils as CDocs
from sanitycheck import sanitycheck

def ends_with_newline(file_path):
    with open(file_path, 'rb') as file:
        file.seek(-1, 2)  # Move the cursor to the last byte of the file
        last_char = file.read(1)
        return last_char == b'\n'

@mkdocs.plugins.event_priority(50000)
def on_page_markdown(markdown: str, page: Page, config: MkDocsConfig, **kwargs) -> str | None:

    if not "status" in page.meta:
        raise Exception("Please Set Status in " + page.file.src_path)

    if not "author" in page.meta:
        raise Exception("Please Set Author in " + page.file.src_path)

    file = "./docs/" + page.file.src_path
    if 0 != sanitycheck(file):
        raise Exception("Sanity Check failed for " + file)


    if not ends_with_newline(file):
        with open(file, "a") as f:
            f.write("\n")
        #raise Exception("Please make sure " + page.file.src_path + " ends with a new line")



    #for name, value in os.environ.items():
    #    markdown += "{0}: {1}\n".format(name, value)

    #for property, value in vars(page).items():
    #    markdown += "{0}: {1}\n".format(property, value)

    data = ""
    if -1 == markdown.find("ProvideFeedback"):
        #encoded = str(page.file.src_path).replace("/", ".")
        encoded = quote(page.file.src_path)

        ret = ""
        ret += "??? danger \"Dynamic Telemetry is a PROPOSAL : please provide feedback! :-)\"\n"
        ret += "    Dynamic Telemetry is not an implementation, it's a request for collaboration, \n"
        ret += "    that will lead to an shared understanding, and hopefully one or more implementations.\n"
        ret += "\n\n"
        ret += "    Your feedback and suggestions on this document are highly encouraged!\n\n"
        ret += "    *Please:*\n\n"
        ret += "    1. Open [this Git Hub Pull Request](https://github.com/microsoft/DynamicTelemetry/pull/6/)\n\n"
        ret += "    1. Locate this file ( **" + page.file.src_path + "**)\n\n"
        ret += "    1. Add Comments! :)\n\n"
        ret += "\n\n"
        ret += "\n\n"
        ret += "    *Direct Sharing URL*\n\n"
        ret += "    ```cdocs\n"
        ret += "    http://microsoft.github.io/DynamicTelemetry/" + page.file.url + "\n"
        ret += "    ```\n\n"

        ret += "    *If you'd prefer to give us a PR*\n\n"
        ret += "    ```cdocs\n"
        ret += "    https://microsoft.github.io/DynamicTelemetry/\n"
        ret += "    ```"
        ret += "\n\n"
        ret += "    Learn about overall document status\n"
        ret += "        [here](./ReviewProcess.document.md)\n"
        ret += "\n\n"
        ret += "    <img src=\"https://durableid-demo-a9byc5fwa7htc5h0.westus2-01.azurewebsites.net/?name=test.jpg&handler=LoadImageFile&pageName=" + encoded + "\"/>"
        ret += "\n\n"

        data += ret
        # data += "{{ProvideFeedback(page.file.src_uri)}}\n"
        data += CDocs.RemoveImageWithAndHeightInfo(markdown)
    else:
        data += CDocs.RemoveImageWithAndHeightInfo(markdown)


    return data