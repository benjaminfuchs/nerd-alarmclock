#!/usr/bin/env python

import cgi
import cgitb

cgitb.enable()

print "Content-type: text/html\n\n"

form=cgi.FieldStorage()

if "post" not in form:
    print "<h1>The text area was empty.</h1>"
else:
    text=form["post"].value
    print "<h1>Text from text area:</h1>"
    print cgi.escape(text)
    with open('/var/www/html/settings.json', 'w') as the_file:
        the_file.write(text)
