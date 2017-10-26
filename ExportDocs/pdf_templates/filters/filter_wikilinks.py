################################################################################
## Wiki Links Filter
##
## Converts links in gollum (GitHub wiki) format to markdown links.
## Assumes that the page the link should point to has an HTML filename equal to
## its canonical name with .html as the extension.
## For example, [[Accessing the Test Environment]] should link to
## Accessing-the-Test-Environment.html
################################################################################

import re

# https://github.com/gollum/gollum/wiki#linking-internal-pages
GOLLUM_LINK = re.compile(r'\[\[([^\]]+)\]\]')

def filter_markdown(md, **kwargs):
    m = re.search(GOLLUM_LINK, md)
    while m:
        # print("found gollum-style link %s" % m)
        link_label = m.group(1)
        # Assume the resulting page has a matching filename that ends in .html
        link_path = link_label.replace("/", "-").replace(" ", "-") + ".html"
        link_text = "[%s](%s)" % (link_label, link_path)
        md = md[:m.start()] + link_text + md[m.end():]
        # Search for next
        m = re.search(GOLLUM_LINK, md)
    return md
