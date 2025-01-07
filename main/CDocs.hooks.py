from __future__ import annotations

import re
import random
from pathlib import Path
from typing import TYPE_CHECKING
import mkdocs.plugins
import CDocs_utils as CDocs


@mkdocs.plugins.event_priority(50000)
def on_page_markdown(markdown: str, page: Page, config: MkDocsConfig, **kwargs) -> str | None:

    if not "status" in page.meta:
        raise Exception("Please Set Status in " + page.file.src_path)

    if not "author" in page.meta:
        raise Exception("Please Set Author in " + page.file.src_path)

    if -1 == markdown.find("ProvideFeedback"):
        data = "{{ProvideFeedback(page.file.src_uri)}}\n"
        data += CDocs.RemoveImageWithAndHeightInfo(markdown)
        return data
        #raise Exception("Needs Feedback : " + page.file.src_path)

    return CDocs.RemoveImageWithAndHeightInfo(markdown)