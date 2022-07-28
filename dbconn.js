/*
  Database connection (dbconn.js)
*/

// Dependencies
const fs = require('fs');
const path = require('path');
const Pool = require('pg').Pool;

// Configuration
config = require('./config.js');

// DB Connection Object
class dbconn {
  /*
   * Constructor
   */
  #pool = null;
  constructor(dbinfo){
    this.#pool = new Pool(dbinfo);
  }
}


