To install a new Drupal site run the following command from the vdd root:

./builder/build.sh -m [SHORT_NAME]

e.g. ./builder/build.sh -m deeson

This will create a new directory for the drupal installation in:

  /Users/[USERNAME]/Sites/deeson.dev

The script will:

 1) Download the latest version of Drupal 7 to the docroot directory
 2) Create a base drush aliases files
 3) Create the default settings.inc file in conf directory
 4) Create the vdd site directory and settings.php file
 5) Create the master.inc file in the conf directory
 6) Generate the config needed to add to the VDD config.json file and display it to the user
 7) Install Drupal using the minimal install profile
 8) Download all the default modules that have been agreed should be present
 9) Download the bootstrap theme and move it to the themes directory
10) Enable the master module
11) Run master-ensure-modules to install all the default modules

BOOM your site is now all set up and configured ready to start building.

** NOTES **
Due to the additional Javascript files that are needed for the navbar module,
these currently need to be manually downloaded into the relevant libraries directory.
