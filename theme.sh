#!/bin/bash

function displayOperation {
  echo -e "\e[7;49;32m$1\e[0m"
}

function displaySuccess {
  echo -e "\e[5;49;32m$1\e[0m"
}

cd /var/www/html/web

read -e -i "$themename" -p "What is the name of the subtheme ? " input
themename="${input:-$themename}"
themepath=themes/custom/${themename}
mkdir themes/custom

displayOperation "Copy bootstrap SASS starterkits"
cp -rf themes/contrib/bootstrap/starterkits/sass ${themepath}

#cd themes/custom/${themename}

displayOperation "Moving bactency files to new theme"
    mv bactency-master/assets/ ${themepath}/assets
    mv bactency-master/bower.json bower.json
    mv bactency-master/config.json config.json
    mv bactency-master/gulpfile.js gulpfile.js
    mv bactency-master/package.json package.json
    mv bactency-master/package-lock.json package-lock.json
    mv bactency-master/README.md ${themepath}/README.md
    mv bactency-master/gulp.sh gulp.sh
    mv bactency-master/.bowerrc .bowerrc

displayOperation "Rename files"
    mv ${themepath}/THEMENAME.starterkit.yml ${themepath}/${themename}.info.yml
    mv ${themepath}/THEMENAME.libraries.yml ${themepath}/${themename}.libraries.yml
    mv ${themepath}/THEMENAME.theme ${themepath}/${themename}.theme
    mv ${themepath}/config/install/THEMENAME.settings.yml ${themepath}/config/install/${themename}.settings.yml
    mv ${themepath}/config/schema/THEMENAME.schema.yml ${themepath}/config/schema/${themename}.schema.yml
    replace=bootstrap/assets
    bootstrapbower=assets/vendors/bootstrap-sass/assets
    sed -i "s/${replace//\//\\/}/${bootstrapbower//\//\\/}/g" ${themepath}/${themename}.libraries.yml
    cssreplace=css/style.css
    cssfolder=assets/css/style.css
    sed -i "s/${cssreplace//\//\\/}/${cssfolder//\//\\/}/g" ${themepath}/${themename}.libraries.yml

displayOperation "Replace token"
    sed -i "s/THEMETITLE/${themename}/g" ${themepath}/${themename}.info.yml
    sed -i "s/THEMENAME/${themename}/g" ${themepath}/${themename}.info.yml
    displaySuccess ${themename}".theme"
    csssrc=${themepath}/assets/scss/**/*.scss
    sed -i "s/CSSSRC/${csssrc//\//\\/}/g" config.json
    cssdest=${themepath}/assets/css
    sed -i "s/CSSDEST/${cssdest//\//\\/}/g" config.json
    jssrc=${themepath}/assets/js/**/*.js
    sed -i "s/JSSRC/${jssrc//\//\\/}/g" config.json
    imgsrc=${themepath}//assets/images/**/*
    sed -i "s/IMGSRC/${imgsrc//\//\\/}/g" config.json
    imgdest=${themepath}/assets/images/
    sed -i "s/IMGDEST/${imgdest//\//\\/}/g" config.json
    fontdest=${themepath}/assets/fonts/
    sed -i "s/FONTDEST/${fontdest//\//\\/}/g" config.json
    sed -i "s/THEMENAME/${themename}/g" config.json
    sed -i "s/THEMENAME/${themename}/g" package.json
    sed -i "s/THEMENAME/${themename}/g" package-lock.json
    sed -i "s/THEMEPATH/${themepath//\//\\/}/g" .bowerrc

    cd ${themepath}
    grep --null -lr "THEMENAME" | xargs --null sed -i "s/THEMENAME/${themename}/g"
    grep --null -lr "THEMETITLE" | xargs --null sed -i "s/THEMETITLE/${themename}/g"
    cd /var/www/html/web
    rm -rf bactency-master

displayOperation "Removing scss drupal bootstrap folder"
    rm -rf ${themepath}/scss

displayOperation "Installing gulp & bower"
    npm run setup
    bower install
    cp ${themepath}/assets/vendors/bootstrap-sass/assets/stylesheets/bootstrap/_variables.scss ${themepath}/assets/scss/_bootstrap-overrides.scss

displayOperation "Gulp installed & compiled"
displayOperation "Activate new theme"
    drush en -y bootstrap
    drush en -y ${themename}
    drush config-set system.theme default ${themename} -y
    drush cr
    gulp css
