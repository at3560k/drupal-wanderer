#!/bin/bash
#  No clue why the exec fails in puppet

cd /drupal_inst 
/usr/bin/drush dl drupal
cd /drupal_inst/drupal-7.22 
/usr/bin/drush --yes site-install standard --account-mail=jbrown@edac.unm.edu --account-name=admin --account-pass=ChangeThis1 --db-url=mysql://root:ChangeThis1@127.0.0.1/drupal
