#!/bin/ksh

# Constants
CONCRETE_TEMPLATE="Templates/ConcreteModuleTemplate"
API_TEMPLATE="Templates/APIModuleTemplate"
FOLDERS=(["Helper"]="Helpers" ["Feature"]="Features" ["Service"]="Services")
MODULE_TYPES=(["Helper"]=".helper" ["Feature"]=".feature" ["Service"]=".service")

# Script params received from Makefile command
moduleName=$1
moduleType="${2:-Feature}"
moduleHasApi="${3:-true}"

change_to_root_directory() {
    # Jump to repository root
    cd "$(git rev-parse --show-toplevel)"
}

check_if_module_already_exists() {
    # Verify if folder already exists
    if [ ! -d "./Modules/${FOLDERS[$moduleType]}/$moduleName$moduleType" ]; then
        echo "Creating $moduleName module"
    else 
        echo "$moduleName folder already exists"; exit 1;
    fi
}

create_module() {
    hasApi=$1

    module="${moduleName}${moduleType}"

    cp -R $CONCRETE_TEMPLATE "Modules/${FOLDERS[$moduleType]}/${module}"

    rename_module $module

    create_api_module_if_needed $module $hasApi
    
    add_module_to_podfile $module
}

rename_module() {
    name=$1

    directory="./Modules/${FOLDERS[$moduleType]}/${name}"

    if [ -d "$directory" ]; then
        cd $directory
    else
        echo "Folder: ${directory} not found"; exit 1; 
    fi

    find . -type d -name "<module_name>*" | rename $name
    find . -type f -name "<module_name>*" | rename $name

    # Rename module content templates
    find . ! -name ".*" -type f -exec sh -c "sed -i '' 's/<module_name>/${name}/g' '{}'" \;
    find . ! -name ".*" -type f -exec sh -c "sed -i '' 's/<module_type>/${MODULE_TYPES[$moduleType]}/g' '{}'" \;

    change_to_root_directory

    add_module_as_superapp_dependency $name
}

rename() {
    name=$1
    # Rename module file and folder name templates
    while read oldName
    do
        newName=$(echo $oldName | sed "s/<module_name>/$name/")
        mv "$oldName" "$newName"
    done
}

add_module_as_superapp_dependency() {
    name=$1
    sed -i '' '1,/Dependencies/s/Dependencies/&\
    .project(target: "'"${name}"'", path: "..\/Modules\/'"${FOLDERS[$moduleType]}"'\/'"${name}"'"),/' ScalableMonorepo/Project.swift
}

create_api_module_if_needed() {
    name=$1
    hasApi=$2
    
    if [ $hasApi == true ]; then
        add_api_module_as_dependency_of_concrete $name
        create_api_module $name
    else
        remove_dependency_mark $name
    fi
}

create_api_module() {
    name="${1}API"

    cp -R $API_TEMPLATE "Modules/${FOLDERS[$moduleType]}/${name}"

    rename_module $name
}

add_api_module_as_dependency_of_concrete() {
    name=$1
    folder=${FOLDERS[$moduleType]}

    dependency='.project(target: "'"${name}API"'", path: "..\/'"${name}API"'"),'
    sed -i '' 's/DependencyAPI/'"${dependency}"'/' Modules/$folder/$name/Project.swift
}

remove_dependency_mark() {
    name=$1
    folder=${FOLDERS[$moduleType]}
    sed -i '' 's/DependencyAPI//' Modules/$folder/$name/Project.swift
}

add_module_to_podfile() {
    # Integrate on Podfile
    name=$1
    type=${FOLDERS[$moduleType]}

    echo '
target '"'$name'"' do
    project '"'Modules/$type/$name/$name.project'"'' >> Podfile

    if [ "$type" != api ]; then
    echo '
    target '"'${name}Sample'"' do
        inherit! :complete
        platform :ios, '"'14.0'"'
    end' >> Podfile

    echo '
    target '"'${name}Tests'"' do
        inherit! :search_paths
    end' >> Podfile
    fi

    echo 'end' >> Podfile
}

change_to_root_directory

check_if_module_already_exists

create_module $moduleHasApi