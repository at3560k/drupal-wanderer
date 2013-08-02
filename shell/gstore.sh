#!/bin/bash
#  No clue why the exec fails in puppet

cd /drupal_inst
/usr/bin/git clone https://github.com/at3560k/drupal-module-gstore.git

cp -r /drupal_inst/drupal-module-gstore/gstore /drupal_inst/drupal-7.22/sites/all/modules/
cd /drupal_inst/drupal-7.22/
/usr/bin/drush --yes pm-enable devel
/usr/bin/drush --yes pm-enable gstore
