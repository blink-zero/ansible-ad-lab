#!/bin/bash

# Save the path to the "vars" folder in a variable
vars_path="$(pwd)/vars"

echo
echo "> Renaming the example variables files..."

# Find all files in the "vars" folder that end with .yml.example
for file in "$vars_path"/*.yml.example; do
    # Get the base filename without the extension
    filename=$(basename "$file" .yml.example)
    # Rename the file with the new extension
    mv "$file" "${vars_path}/${filename}.yml"
done

# Save the path to the "inventory" in variable
inv_path="$(pwd)"

echo
echo "> Renaming the example inventory file..."

# Find all files that end in .ini.example
for file in "$inv_path"/*.ini.example; do
    # Get the base filename without the extension
    filename=$(basename "$file" .ini.example)
    # Rename the file with the new extension
    mv "$file" "${inv_path}/${filename}.ini"
done

echo
echo "> Done."