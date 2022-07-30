/* 
   config.js
   Main configuration file for the application
*/
const ini = require('ini');
const fs = require('fs');

cfgPath = './config.ini';
const config = ini.parse(fs.readFileSync(cfgPath, 'utf-8'));

/*
const server = {
    port:3000
};
const database = {
    user: "dbuser",
    password: "dbpassword",
    database: "db", 
    port: 5432,
    host: "localhost" 
};

// Do not change.
const config = {
    server:server,
    database:database
};
*/

module.exports = config;
