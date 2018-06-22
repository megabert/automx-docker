#!/bin/bash -e

out() { echo "$(date): $*"; }

get_templates() {
	find . -type f -name "*.erb"
}

process_templates() {

	out "Rendering Templates..."
	while read file ; do
		new_file="${file%.erb}"
		./bin/erbreplace "$file" >"$new_file"
	done < <(get_templates)
}

pre_build() {

	# Execute Script as root prior to the build process
	# 
	# * fetch ssl certificates from protected folder
	#
	# * set acl for db_data container which is changed inside 
	#  the container after start
	# 

	pre_build_script=./pre-build-root.sh
	if [ -x $pre_build_script ] ; then
		out "Executing Pre-Build Script as root..."
		sudo $(pwd)/$pre_build_script
	fi
}

run_docker_container() {
	out "Creating and running docker images..."
	out "Building config_db"
	cd config_db
	bash ./build.sh
	cd ..

	out "Building automx"
	cd automx
	bash ./build.sh
}

cd $(dirname $0)
pre_build
process_templates
run_docker_container
