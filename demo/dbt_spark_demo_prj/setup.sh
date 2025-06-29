#!/bin/bash

# enable detail log
# export PS4='+${BASH_SOURCE}:${LINENO}:${FUNCNAME[0]}: ' # Customize the debug prompt
# set -x

# Source the .env file to load environment variables
# Ensure this path is correct relative to where you run the script
. ../../.env

# Check if DBT_PROJECT_DIR is set after sourcing
if [ -z "$DBT_PROJECT_DIR" ]; then
  echo "Error: DBT_PROJECT_DIR is not set. Please check your .env file."
  exit 1
  else
  echo DBT_PROJECT_DIR $DBT_PROJECT_DIR
fi

# set dbt profile.yml
mkdir ~/.dbt
cp -v /usr/app/demo/profiles.yml ~/.dbt/
pushd $DBT_TOP_DIR
echo pwd $(pwd)
rm -r $DBT_PROJECT_NAME/{macros,models,tests,seeds}
popd
cp -r --verbose ./{macros,models,tests,seeds,dbt_project.yml} $DBT_TOP_DIR/$DBT_PROJECT_NAME
chmod a+rw -R $DBT_TOP_DIR/$DBT_PROJECT_NAME
