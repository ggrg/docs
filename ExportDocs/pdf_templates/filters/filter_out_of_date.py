################################################################################
## Out of Date Filter
##
## Mark pages as out-of-date by adding markers:
## > ***OUT OF DATE STARTS HERE***
##
## Out-of-date content here
##
## > ***OUT OF DATE ENDS HERE***
##
## Up-to-date content here (blank line above necessary)
################################################################################

import re

START_MARKER = r'^>\s+[*]{2,3}OUT OF DATE STARTS HERE[*]{2,3}$'
END_MARKER = r'^>\s+[*]{2,3}OUT OF DATE ENDS HERE[*]{2,3}$'

START_HTML = '<div class="out-of-date" markdown="1"><strong class="ood-header">Out of Date Content</strong>'
END_HTML = '</div>'

def filter_markdown(md, **kwargs):
    md = re.sub(START_MARKER, START_HTML, md, flags=re.MULTILINE)
    md = re.sub(END_MARKER, END_HTML, md, flags=re.MULTILINE)
    return md
