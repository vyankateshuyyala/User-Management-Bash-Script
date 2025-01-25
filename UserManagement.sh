#!/bin/bash

# Set the default password expiration and other policies
PASSWORD_EXPIRY_DAYS=90
MIN_PASSWORD_LENGTH=8
MAX_PASSWORD_AGE=365
PASSWORD_WARN_DAYS=7

# Function to create group if it doesn't exist
create_group() {
    group_name=$1
    if ! grep -q "^$group_name:" /etc/group; then
        echo "Creating group: $group_name"
        groupadd "$group_name"
    else
        echo "Group $group_name already exists."
    fi
}

# Function to add a user
add_user() {
    username=$1
    password=$2
    fullname=$3
    group_name=$4

    echo "Adding user: $username"
    # Create group if necessary
    create_group "$group_name"

    # Create the user and set the group
    useradd -m -G "$group_name" -c "$fullname" -s "/bin/bash" "$username"

    # Set the password
    echo "$username:$password" | chpasswd

    # Enforce password policies
    chage -M "$MAX_PASSWORD_AGE" -m "$MIN_PASSWORD_LENGTH" -W "$PASSWORD_WARN_DAYS" "$username"
    chage -I -1 -E $(date -d "$PASSWORD_EXPIRY_DAYS days" +%Y-%m-%d) "$username"

    echo "User $username added successfully."
}

# Function to delete a user
delete_user() {
    username=$1
    echo "Deleting user: $username"
    userdel -r "$username"
    echo "User $username deleted successfully."
}

# Function to display options
show_menu() {
    echo "User Management Script"
    echo "1. Add a User"
    echo "2. Delete a User"
    echo "3. Exit"
    read -p "Choose an option [1-3]: " option
}

# Function to handle adding a user
handle_add_user() {
    read -p "Enter username: " username
    read -sp "Enter password: " password
    echo
    read -p "Enter full name: " fullname
    read -p "Enter group name: " group_name

    if [ -n "$username" ] && [ -n "$password" ] && [ -n "$fullname" ] && [ -n "$group_name" ]; then
        add_user "$username" "$password" "$fullname" "$group_name"
    else
        echo "All fields are required!"
    fi
}

# Function to handle deleting a user
handle_delete_user() {
    read -p "Enter username to delete: " username

    if [ -n "$username" ]; then
        delete_user "$username"
    else
        echo "Username is required to delete a user."
    fi
}

# Main loop to display the menu and perform actions
while true; do
    show_menu
    case "$option" in
        1)
            handle_add_user
            ;;
        2)
            handle_delete_user
            ;;
        3)
            echo "Exiting User Management Script."
            break
            ;;
        *)
            echo "Invalid option. Please choose a valid option."
            ;;
    esac
done
