This is our Actency Bootstrap SASS sub-theme, using by drupency install profile.
We can work here on a cool out of the box version for every new projects :)
Do not sub-theme this theme again, simply use it as is.
You can rename it for your project but be careful with hooks etc.

###INSTALATION
If you install this theme with Actency Drupalm 8 starterkit, the new Boostrap Subtheme 
will be automatically installed while running this command :
```
../scripts/drupal/install.sh
```

If you want to install this subtheme with an other Drupal 8 installation, follow this
steps :

1. Make sure Boostrap theme is located in htdocs/web/theme/contrib/bootstrap folder
2. Download this subtheme 
3. Move theme.sh to web folder
4. Run ```bash theme.sh``` command


###GULP

**Installation**

Gulp is already installed while running theme.sh script, but if you want to
reinstall gulp follow this step

1. Make sure you have latest node and npm latest version
2. cd into web folder en run :

```
bash gulp.sh
```


**GULP COMMAND :**

* **gulp** : 
Default watch

* **gulp css** :
Compile scss files

* **gulp images** :
Images minification

* **gulp drush** :
drush cache-clear theme-registry


Feel free to add other custom command in gulpfile.js located in /web filder

### Install Vendors

All vendors are versioned, so nothing must be done when installing the project. 
They are located in web/themes/custom/MYTHEME/assets/vendors folder.

**You must use bower when you install a new vendor :**

Go to web folder and run this commands :
```
bower install --save my_vendor
```
If you want to install a specific version :
```
bower install --save my_vendor#version
```

**Then you must you must add .scss in your style.scss files, and .js on MYTHEME.libraries.yml**