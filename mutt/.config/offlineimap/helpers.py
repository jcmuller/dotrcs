#!/usr/bin/python

import re
import sys
import gtk
import keyring

def get_password(server):
    return keyring.get_password("offlineimap", server)

def oimaptransfolder_gmail(foldername):
    # Inbox has the normal name, all other have trailing '[Gmail]'
    if(foldername == "INBOX"):
        retval = "gmail"
    else:
        retval = "gmail." + foldername
    # Now replace any funny gmails that gmail put there
    retval = re.sub("\[Gmail\].", "", retval)
    retval = re.sub("/", ".", retval)
    return retval
