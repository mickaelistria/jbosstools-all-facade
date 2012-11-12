#!/bin/bash

submodules="jbosstools-build
jbosstools-base
jbosstools-server
jbosstools-openshift
jbosstools-webservices
jbosstools-jst
jbosstools-forge
jbosstools-esb
jbosstools-bpel
jbosstools-runtime-soa
jbosstools-javaee
jbosstools-jbpm
jbosstools-portlet
jbosstools-gwt
jbosstools-freemarker
jbosstools-birt
jbosstools-vpe
jbosstools-central
jbosstools-integration-tests
jbosstools-build-sites
jbosstools-documentation
jbosstools-build-ci
jbosstools-website
jbosstools-documentation"

usage() {
	echo "Script to manipulte submodules"
	echo "Usage"
	echo "	init <refspec>	Initializae submodules at the given refspec"
	echo "			(typical usage is a tag or branch id"
}

# Admon only! Initialize a new git repo from the list of JBT submodules
create() {
	for submodule in $submodules; do
		git submodule add git://github.com/jbosstools/$submodule $submodule
	done
}

init() {
	if [ -z "$1" ]; then
		ref=master
	else
		ref="$1"
	fi
	for submodule in $submodules; do
		pushd $submodule
		git submodule init
		git submodule update
		git checkout $ref
		popd
	done
}

# Admin onlyi! Creates a pom from the modules list
# pom has to be tweaked after to remove non-code modules
generate_pom() {
	echo "<?xml version='1.0' encoding='UTF-8'?>
<project xmlns='http://maven.apache.org/POM/4.0.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance'
	xsi:schemaLocation='http://maven.apache.org/POM/4.0.0 http://maven.apache.org/xsd/maven-4.0.0.xsd'>
	<modelVersion>4.0.0</modelVersion>
	<groupId>org.jboss.tools</groupId>
	<artifactId>all</artifactId>
	<version>0.0.1-SNAPSHOT</version>
	<packaging>pom</packaging>

	<modules>" > pom.xml
	for submodule in $submodules; do
		echo "		<module>$submodule</module>" >> pom.xml
	done
	echo "	</modules>" >> pom.xml
	echo "</project>" >> pom.xml
}

action=$1
param=$2

if [ "$action" == "init" ]; then
	init $param
elif [ "$action" == "create" ]; then
	create
elif [ "$action" == "generate_pom" ]; then
	generate_pom
else
	usage
fi
