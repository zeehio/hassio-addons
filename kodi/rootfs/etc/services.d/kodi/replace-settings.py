#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Wed Jul  6 16:58:19 2022

@author: sergio

Takes a guisettings.xml from Kodi and modifies some settings
according to user preferences
"""

import json
import logging
import os
import shutil

from xml.etree import ElementTree as et

logger = logging.Logger(__name__)

logger.info("Loading options from /data/options.json")

with open("/data/options.json") as fh:
    settings = json.load(fh)


logger.info("Reading the guisettings.xml file...")
guisettings_fn = "/data/kodi/userdata/guisettings.xml"

if not os.path.exists(guisettings_fn):
    shutil.copyfile("/etc/services.d/kodi/guisettings.xml", guisettings_fn)

# Read the xml file
tree = et.parse(guisettings_fn)

logger.info("Updating the kodi settings based on the add-on settings...")
# Modify the web settings attributes:
tree.find("./setting[@id='services.webserver']").text = str.lower(str(settings['webserver']))
tree.find("./setting[@id='services.webserverport']").text = '8080'
tree.find("./setting[@id='services.webserverauthentication']").text = str.lower(str(settings['webserverauthentication']))
tree.find("./setting[@id='services.webserverusername']").text = str(settings["webserverusername"])
tree.find("./setting[@id='services.webserverpassword']").text = str(settings["webserverpassword"])
tree.find("./setting[@id='services.webserverssl']").text = 'false'


logger.info("Writing the new settings to file...")
# Write to the file
tree.write(guisettings_fn)
logger.info("Kodi settings updated.")
