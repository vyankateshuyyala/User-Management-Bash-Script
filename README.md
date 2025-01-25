# User-Management-Bash-Script



Explanation:
Password Policies:

Password Expiry: Passwords expire after 90 days.
Minimum Password Length: Passwords must be at least 8 characters long.
Maximum Password Age: Passwords must be changed within 365 days.
Password Expiry Warning: 7 days before the password expires.
Group Creation:

Before adding a user, the script checks if the group exists. If the group doesn’t exist, it will create it using groupadd.
User Creation:

The script prompts the user for the username, password, full name, and group. It then creates the user and applies the password policies using chage.
User Deletion:

The script will prompt you for the username and remove the user with userdel -r (which also removes the user's home directory).
Menu Interface:

The script provides a simple menu that allows the user to choose whether to add a user, delete a user, or exit the script.
Usage:
Make the script executable:

bash

chmod +x user_management.sh
Run the script:

bash

./user_management.sh
Script Behavior:

When you run the script, you'll see a menu with three options:
Add a User: Prompts you for the username, password, full name, and group to add a new user.
Delete a User: Prompts you for the username to delete an existing user.
Exit: Exits the script.
Example Interaction:
-------SQl------
User Management Script
1. Add a User
2. Delete a User
3. Exit
Choose an option [1-3]: 1
Enter username: johndoe
Enter password: ********
Enter full name: John Doe
Enter group name: users
User johndoe added successfully.

User Management Script
1. Add a User
2. Delete a User
3. Exit
Choose an option [1-3]: 2
Enter username to delete: johndoe
User johndoe deleted successfully.

User Management Script
1. Add a User
2. Delete a User
3. Exit
Choose an option [1-3]: 3
Exiting User Management Script.
Notes:
Security Considerations: The password input is hidden (-s option with read) to ensure privacy during input.
Validation: The script checks for missing input fields when adding a user or deleting a user and prompts you again if necessary.
