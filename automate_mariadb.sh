#!/bin/bash

# Database details
db_name="kodekloud_db01"
db_user="kodekloud_roy"
db_password="asdfgdsd"

# Check if the database already exists
if mysql -u root -e "USE $db_name" 2>/dev/null; then
    echo "Database already exists"
else
    # Create the database
    mysql -u root -e "CREATE DATABASE $db_name"
    echo "Database $db_name has been created"
fi

# Check if the database is empty
table_count=$(mysql -u root $db_name -e "SHOW TABLES" | wc -l)
if [ "$table_count" -gt 0 ]; then
    echo "Database is not empty"
else
    # Import the database dump
    mysql -u root $db_name < /opt/db_backups/db.sql
    echo "Imported database dump into $db_name database"
fi

# Take a mysql dump and save it under /opt/db_backups/
mysqldump -u root $db_name > /opt/db_backups/kodekloud_db01.sql

# Set permissions for the user
mysql -u root -e "GRANT ALL PRIVILEGES ON $db_name.* TO '$db_user'@'%' IDENTIFIED BY '$db_password'; FLUSH PRIVILEGES;"

echo "Script execution complete."

#Make sure to:

#Give execute permission to the script using chmod +x /opt/scripts/database.sh.
#Replace the values of db_name, db_user, and db_password with your desired database, username, and password.
#Ensure that you have the /opt/db_backups/db.sql file containing the database dump you want to import.
#Run the script with root privileges or ensure that the user running the script has the necessary permissions to create databases and users.
