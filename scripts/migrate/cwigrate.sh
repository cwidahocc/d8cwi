#!/bin/bash

#who="World"
#echo "Hello, $who!"

#parameter expansion
#echo "Hello, ${who}!"
#echo "Hello, $(whoami)!"

#Arrays
#beatles=('John' 'Paul' 'George' 'Ringo')
#echo ${beatles[0]}

echo 'Press 1 to Migrate or 2 to Rollback! Anything else is a waste of cycles'

#age
read answer

if [ $answer -eq 1 ]
then
    echo 'You are Migrating.'
    lando drush mim --group="tax_prep"  #Taxonomy
    lando drush mim --group="paragraphs" #Paragraphs and Field Collections
    lando drush mim --group="node_prep" #Node, Fields, Field Formatters, Field Widgets, View Modes
    #lando drush mim --group="file" # Files will copy from web/d7files - keep disabled until for reals, lengthy
    lando drush mim --group="tax_content" #Taxonomy Content
    lando drush mim --group="user" #Add User Content and Roles before Node Content
    lando drush mim --group="node_content" #Add Node Content
    #Add Node Revision ????
    lando drush mim --group="book" #Add Book Settings
    #Add Image styles ??????
    #Add Menu n Menu Links ?????
    lando drush mim --group="url" #Add URL alias

elif [ $answer -eq 2 ]
then
    echo 'You are Rolling Back.'
    lando drush mr --group="url"
    lando drush mr --group="book"
    lando drush mr --group="node_content"
    lando drush mr --group="user"
    lando drush mr --group="tax_content"
    #lando drush mr --group="file"
    lando drush mr --group="node_prep"
    lando drush mr --group="paragraphs"
    lando drush mr --group="tax_prep"

else
  echo 'You are way too young to drink.'

fi