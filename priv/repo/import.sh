#!/bin/bash

# Defaults
host="localhost"
port=5432

# Parse command line arguments
while getopts ":d:u:p:h:P:" opt; do
  case $opt in
  d) database="$OPTARG" ;;
  u) username="$OPTARG" ;;
  p) password="$OPTARG" ;;
  h) host="$OPTARG" ;;
  P) port="$OPTARG" ;;
  \?) echo "Invalid option -$OPTARG" >&2 ;;
  esac
done

# Construct the URI string
uri="postgresql://$username:$password@$host:$port/$database"

# Connect to the database and execute SQL files
for file in $(find "./sql" -type f | sort); do
  psql "$uri" -f "$file" >/dev/null 2>&1
done
