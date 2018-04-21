#!/bin/sh
archive=<%= scope['dokuwiki::tmp_dir'] %>/<%= scope['dokuwiki::archive'] %>
install_path=<%= scope['dokuwiki::install_path'] %>
if [ $archive ]; 
then
  version=$(tar -xf $archive --wildcards \*/VERSION -O | cut -d' ' -f1)
  if [ -d $install_path/dokuwiki-${version} ]; 
  then
    ln -s $install_path/dokuwiki-${version} $install_path/dokuwiki
  fi
else
  exit 1
fi
