#!/bin/sh
# POSIX
#
# This file was writen for FreeBSD 13.1 on 2022-08-17, if it no longer works look into what the package new names may have changed to.
# DO NOT RUN THIS SCRIPT TO UPDATE YOUR PACKAGES
# This script should ONLY be run on virgin virtual machines, installations and jails. 
# If PostgreSQL or NodeJS were previously installed, update them manually instead.
# This script presumes it will be run from the folder in which the cloud storage user home directory will be in.
#
# This file is licensed under the BSD Zero Clause License
#
# Copyright (c) 2022 Superfly Johnson
#
# Permission to use, copy, modify, and/or distribute this software for any
# purpose with or without fee is hereby granted.
#
# THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES WITH
# REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF MERCHANTABILITY
# AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY SPECIAL, DIRECT,
# INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES WHATSOEVER RESULTING FROM
# LOSS OF USE, DATA OR PROFITS, WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE OR
# OTHER TORTIOUS ACTION, ARISING OUT OF OR IN CONNECTION WITH THE USE OR
# PERFORMANCE OF THIS SOFTWARE.

user=cloudstoragecompuser
password=example-password
database=cloudstoragecompdb
initdbargs="-u $user -p $password -d $database"

echo "Updated package repository..."
pkg update
echo "Installing NodeJS, NPM and PostgreSQL..."
pkg install npm-node18 postgresql15-server postgresql15-client
echo "Enabling postgresql..."
service postgresql enable
echo "Initiatlizing postgresql's database"
/usr/local/etc/rc.d/postgresql initdb
echo "Starting the postgresql service"
service postgresql start
echo "Creating the cloudstoragecompare user with username $user..."
pw adduser $user -g www -d $(dirname -- $0) -s /usr/sbin/nologin -c "Cloud Storage Account user."
echo "Changing ownership of $0/.. to $user:www"
chown -R cloudstoragecompareuser:www $(dirname -- $0)
echo "Running database initialization script with arguments $initdbargs" 
su -m postgres -c "$(dirname -- $0)/initdb.sh $initdbargs"
