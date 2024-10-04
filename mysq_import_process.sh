#!/bin/bash

# Variables
SQL_FILE="viptutor_live_2024-09-13_00-00-01.sql" 
DOCKER_CONTAINER="mysql-8-0"
DB_NAME="viptutors_db"
MYSQL_USER="root"
MYSQL_PASS="vG7n4AP9NSCmXNLg"

# Check if pv is installed pv for realtime percentage process.
if ! command -v pv &> /dev/null; then
    echo "pv is not installed. Installing..."
    sudo apt-get update 2>/dev/null
    yes | sudo apt-get install pv 2>/dev/null
fi

# Get the total size of the SQL file
TOTAL_SIZE=$(du -b "$SQL_FILE" | cut -f1)

# Start the import process with pv for real-time progress
echo "Importing SQL file..."
pv -cN source "$SQL_FILE" | docker exec -i "$DOCKER_CONTAINER" mysql -u "$MYSQL_USER" -p"$MYSQL_PASS" "$DB_NAME" 2>/dev/null 

# After the import, calculate the current database size
CURRENT_SIZE=$(docker exec -i "$DOCKER_CONTAINER" mysql -u "$MYSQL_USER" -p"$MYSQL_PASS" -e "SELECT SUM(data_length + index_length) AS total_size FROM information_schema.TABLES WHERE table_schema = '$DB_NAME';" 2>/dev/null | tail -n1)

# Calculate the final percentage of import completed
if [[ -n $CURRENT_SIZE && $CURRENT_SIZE -gt 0 ]]; then
    PERCENTAGE=$(echo "scale=2; ($CURRENT_SIZE / $TOTAL_SIZE) * 100" | bc)
    echo -e "\nImport Completed: $PERCENTAGE%"
else
    echo -e "\nImport Completed: 0%"
fi