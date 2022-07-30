/*
  Database connection (dbconn.js)
*/

// Dependencies
const Pool = require('pg').Pool;

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

module.exports = dbconn;
