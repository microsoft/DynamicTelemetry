#!/usr/bin/env python3

from sanitycheck_helpers import sanitycheck

retval = 0
retval += sanitycheck('.github/**/*.md', allow_eol = (LF,))
retval += sanitycheck('.github/**/*.yml', allow_eol = (LF,), indent = 2)
retval += sanitycheck('**/*.css', allow_eol = (LF,), indent = 2)
retval += sanitycheck('**/*.htm', allow_eol = (LF,), indent = 4)
retval += sanitycheck('**/*.html', allow_eol = (LF,), indent = 4)
retval += sanitycheck('**/*.md', allow_eol = (LF,))
retval += sanitycheck('**/*.py', allow_eol = (LF,), indent = 4)
retval += sanitycheck('**/*.yml', allow_eol = (LF,), indent = 2)

sys.exit(retval)
