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

echo "Copy bootstrap SASS starterkits"
cp -rf themes/contrib/bootstrap/starterkits/sass themes/custom/${themename}

cd themes/custom/${themename}

displayOperation "Downloading bootstrap framework"
wget "https://github.com/twbs/bootstrap-sass/archive/master.zip"
            unzip "master.zip"
            rm "master.zip"
            mv bootstrap-sass-master bootstrap

displayOperation "Rename files"
    mv THEMENAME.starterkit.yml ${themename}.info.yml
    displaySuccess ${themename}".info.yml"
    mv THEMENAME.libraries.yml ${themename}.libraries.yml
    displaySuccess ${themename}".libraries.yml"
    mv THEMENAME.theme ${themename}.theme
    sed -ie "s/THEMETITLE/${themename}/g" ${themename}.info.yml
    displaySuccess ${themename}".theme"
    rm ${themename}.info.ymle

displayOperation "Moving files"
    mv scss/ sass
    mkidr bootstrap
    mv component bootstrap/component
    mv jquery-ui bootstrap/jquery-ui
displaySuccess "Boostrap sass files moved"

    cp ../bactency/gulpfile.js gulpfile.js
    cp ../bactency/package.json package.json
    cp ../bactency/readme.md readme.md
displaySuccess "Bactency files moved"

displayOperation "Installing gulp"
    npm run setup

gulp sass

displaySuccess "Gulp installed & compiled"
displayOperation "Activate new theme"
    cd ../../
    drush drush config-set system.theme default ${themename} -y
    drush cr
