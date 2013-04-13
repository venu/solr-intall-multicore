#!/bin/bash -e	 	
# -e: Exit immediately if a command exits with a non-zero status.

# Install dependencies depending of the distribution family
echo "Download dependencies"
sudo apt-get install -y openjdk-6-jre openjdk-6-jdk
sudo apt-get install -y solr-jetty

#DIRS
SCRIPT=$(readlink -f $0)
BASEDIR=`dirname $SCRIPT`/conf
HOME_INSTALL=/usr/share/solr
DATA_INSTALL=/var/lib/solr

# Copy Solr context from source
echo "modify jetty"
sudo cp $BASEDIR/jetty /etc/default/jetty

# Copy Solr xml
echo "Copy Solr xml"
sudo cp $BASEDIR/solr.xml $HOME_INSTALL/solr.xml

#create data directory for core0 core
sudo mkdir -p $DATA_INSTALL/core0/data

#Set folder owners to jetty.
sudo chown -R jetty:jetty $DATA_INSTALL
sudo chown -R jetty:jetty $HOME_INSTALL

#create the config for core0 core
sudo mkdir -p $HOME_INSTALL/core0
sudo mkdir -p $HOME_INSTALL/core0/conf

# Copy Solr xml 
echo "Copy the core0 config files"
sudo cp $BASEDIR/conf/schema.xml $HOME_INSTALL/core0/conf/schema.xml
sudo cp $BASEDIR/conf/solrconfig.xml $HOME_INSTALL/core0/conf/solrconfig.xml
sudo cp $BASEDIR/conf/stopwords.txt $HOME_INSTALL/core0/conf/stopwords.txt
sudo cp $BASEDIR/conf/synonyms.txt $HOME_INSTALL/core0/conf/synonyms.txt

sudo /etc/init.d/jetty restart

exit 0