from __future__ import annotations

import re
import random
from pathlib import Path
from typing import TYPE_CHECKING
import mkdocs.plugins
import CDocs_utils as CDocs


@mkdocs.plugins.event_priority(50000)
def on_page_markdown(markdown: str, page: Page, config: MkDocsConfig, **kwargs) -> str | None:


    if -1 == markdown.find("ProvideFeedback"):
        data = "{{ProvideFeedback(page.file.src_uri)}}\n"
        data += CDocs.RemoveImageWithAndHeightInfo(markdown)

        print(markdown)
        return data
        #raise Exception("Needs Feedback : " + page.file.src_path)

    return CDocs.RemoveImageWithAndHeightInfo(markdown)