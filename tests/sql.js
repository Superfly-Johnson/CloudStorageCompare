/*
  Test to SQL's stored procedures.
*/
const config = require("../config.js");
const dbconn = require("../dbconn.js");
const Pool = require('pg').Pool;

// conn = new dbconn(config.database);

const conn = new Pool(config.database);
Company = 'Microsoft';
conn.query(`SELECT AddCompany($Company)`, [1], (err, res) => {
  if (err) {
	throw err
  }

  console.log('id:', res.rows[0]);
});
