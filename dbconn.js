/*
  Database connection (dbconn.js)
*/

// Dependencies
const Pool = require('pg').Pool;

// Configuration
config = require('./config.js');

// Sets up the pool.
const pool = new Pool(config.database);

// Tests if the database connection was successful
pool.connect((err, client, release) => {
  if (err) {
    return console.error('Error acquiring client', err.stack)
  }
  client.query('SELECT NOW()', (err, result) => {
    release()
    if (err) {
      return console.error('Error executing query', err.stack)
    }
    console.log(result.rows)
  })
})
