To install a new Drupal site run the following command from the vdd root:

./builder/build.sh -m [SHORT_NAME]

e.g. ./builder/build.sh -m deeson

This will create a new directory for the drupal installation in:

  /Users/[username]/Sites/deeson.dev

The script will:

 1) Download the latest version of Drupal 7 to the docroot directory
 2) Create the correct drush aliases files
 3) Create the default settings.inc file
 4) Create the vdd site directory and settings.php file
 5) Create the master.inc file
 6) Generate the config needed to add to the VDD config.json file and display it to the user
 7) Install the base minimal install profile of Drupal
 8) Download all the default modules that have been agreed should be present
 9) Download the bootstrap theme and move it to the themes directory
10) Enable the master module
11) Run master-ensure-modules to install all the default modules

BOOM your site is now all set up and configured ready to start building.

** NOTES **
Due to the additional Javascript files that are needed for the navbar module,
these currently need to be manually downloaded into the relevant libraries directory.


Due to the new ay of working, a git repo will probably have already been created
which will already have a docroot and base install of Drupal (as UX/ frontend use
Dev Desktop).
In this case the easiest thing to do is to temporarily rename the project folder
that has been created and install the new site. Once installed you can copy the
docroot directory to the git repo and rename the project directory back to the
original name.
** @todo need to update the script to cater for this **