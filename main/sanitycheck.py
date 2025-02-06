#!/usr/bin/env python3

import glob
import os
import sys

from sanitycheck_helpers import sanitycheck

CR = b'\r'
CRLF = b'\r\n'
LF = b'\n'

retval = 0
retval += sanitycheck('.github/**/*.md', allow_eol = (LF,))
retval += sanitycheck('.github/**/*.yml', allow_eol = (LF,), indent = 2)
retval += sanitycheck('**/*.cs', allow_eol = (LF,), indent = 2)
retval += sanitycheck('**/*.css', allow_eol = (LF,), indent = 2)
retval += sanitycheck('**/*.htm', allow_eol = (LF,), indent = 4)
retval += sanitycheck('**/*.html', allow_eol = (LF,), indent = 4)
retval += sanitycheck('**/*.json', allow_eol = (LF,), indent = 2)
retval += sanitycheck('**/*.js', allow_eol = (LF,), indent = 2)
retval += sanitycheck('**/*.md', allow_eol = (LF,))
retval += sanitycheck('**/*.py', allow_eol = (LF,), indent = 4)
retval += sanitycheck('**/*.sh', allow_eol = (LF,), indent = 4)
retval += sanitycheck('**/*.yaml', allow_eol = (LF,), indent = 2)
retval += sanitycheck('**/*.yml', allow_eol = (LF,), indent = 2)

sys.exit(retval)
