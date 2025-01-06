from __future__ import annotations

import re
import random
from pathlib import Path
from typing import TYPE_CHECKING
import CDocs_utils as CDocs


def on_page_markdown(markdown: str, page: Page, config: MkDocsConfig, **kwargs) -> str | None:
    return CDocs.RemoveImageWithAndHeightInfo(markdown)