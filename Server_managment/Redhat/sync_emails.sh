#!/bin/bash
########################################################################
#                                                                      #
# A shell script to sync IMAP email accounts                           #
# Author: Imran Hasan                                                  #
# Email: imranhasan1846bd@gmail.com                                    #
########################################################################

host1=$1
user1=$2
pass1=$3

host2=$4
user2=$5
pass2=$6  # This was incorrectly using pass1, changed it to pass2

# Check if the current user is root or not
if [[ $(/usr/bin/id -u) -ne 0 ]]; then  # Fixed the syntax for the condition
    echo -e "Please become root user to perform the sync"
    exit 1
fi

install_imapsync() {
    yum install epel-release -y  # Fixed 'rpel-release' typo to 'epel-release'
    yum install imapsync -y
}

check_imapsync() {
    if hash imapsync 2>/dev/null; then
        echo -e "\nImapsync exists successfully. Connecting with the Syncing process."
    else
        echo -e "Installing imapsync."
        install_imapsync
    fi
}

sync_emails() {
    echo -e "\nSyncing emails now...\n"
    imapsync --host1 "$host1" --user1 "$user1" --password1 "$pass1" --host2 "$host2" --user2 "$user2" --password2 "$pass2" --automap
    echo -e "\nEmail Sync complete...\n"
}

check_imapsync
sync_emails
