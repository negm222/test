#!/bin/bash

project_menu() {
    PS3="Please Enter The option: "
    options=("Add User" "Modify User" "Delete User" "detail user"  "List Users" "Add Group" 
             "Modify Group" "Delete Group" "List Groups" "Disable User"
             "Enable User" "Change Password"
             "About" "Exit")
    select I in "${options[@]}"
    do
        case $I in
            "Add User")
                add_user
                ;;
            "Modify User")
                modify_user
                ;;
            "Delete User")
                delete_user
                ;;
            "detail user")
                 detail_user
                 ;;
            "List Users")
                list_users
                ;;
            "Add Group")
                add_group
                ;;
            "Modify Group")
                modify_group
                ;;
            "Delete Group")
                delete_group
                ;;
            "List Groups")
                list_groups
                ;;
            "Disable User")
                disable_user
                ;;
            "Enable User")
                enable_user
                ;;
            
             "Change Password")
                change_password
                ;;
            "About")
                about
                ;;
            "Exit")
                echo " Exit "
                break
                ;;
            *)
                echo " Option Is Not Exist $REPLY"
                ;;
        esac
    done
}

add_user() {
    read -p "Please Enter username to add : " username
if id "$username" &>/dev/null; then
   echo "username is existed"
else
    sudo useradd -m    "$username"
    echo "User '$username' added successfully."
fi
}

modify_user() {
   read -p "Please Enter username to modify : " username

if id "$username" &>/dev/null; then
read -p " Please Enter username to newuser : " username1
    sudo usermod -l  "$username1" "$username"
    echo "User '$username' modified successfully."

else
    echo "Username is not exist"
fi
}

delete_user() {
    read -p " Please Enter username to delete: " username
if id "$username" &>/dev/null; then
    sudo userdel "$username"
    echo "User '$username' deleted successfully."
else
    echo "Username is not exist"
fi
}

detail_user() {
    read -p "Please Enter username to show details: " username
    if id "$username" &>/dev/null; then
        echo "Details for user $username:"
        id "$username"
        sudo chage -l "$username"
    else
        echo "User $username does not exist."
    fi
}


list_users() {
    echo "List all users :"
    cut -d: -f1 /etc/passwd
}

add_group() {

    read -p "Please Enter group name to add: " groupname
   if getent group "$groupname" > /dev/null 2>&1; then
    echo "group is exist " 
    else
    sudo groupadd  "$groupname"
    echo "Group '$groupname' added successfully."
   fi
}

modify_group() {
    read -p " Please Enter group name to modify: " groupname
   if getent group "$groupname" > /dev/null 2>&1; then
   read -p "Enter group name to newgroup:" groupname1
    sudo groupmod -n  "$groupname1"  "$groupname"
        echo "Group '$groupname' modified successfully."
   else
   echo "group not exist"
  fi
  
}

delete_group() {
    read -p " Please Enter group name to delete: " groupname
     if getent group "$groupname" > /dev/null 2>&1; then
    sudo groupdel "$groupname"
    echo "Group '$groupname' deleted successfully."
    else
     echo "group is not exist"
    fi
}

list_groups() {
    echo "List all groups:"
    cut -d: -f1 /etc/group
}

disable_user() {
    read -p "Please Enter username to disable: " username
     if id "$username" &>/dev/null; then
    sudo usermod -L "$username"
    echo "User '$username' disabled successfully."
    else 
    echo "user is not exist"
    fi
}

enable_user() {
    read -p "Please Enter username to enable: " username
    if id "$username" &>/dev/null; then
    sudo usermod -U "$username"
    echo "User '$username' enabled successfully."
    else
    echo "user is not exist "
    fi
}

change_password() {
    read -p " Please Enter username to change password: " username
    sudo passwd "$username"
    echo "Password changed for user '$username'."
}

about() {
    echo "The Project Is Created By Ahmed Negm"
}

project_menu
