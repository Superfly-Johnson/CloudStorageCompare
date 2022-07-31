/*
  Test to SQL's stored procedures.
*/
const Pool = require('pg').Pool;

const pool = new Pool();

Companies = [ 'Microsoft OneDrive', 'Amazon Cloud Drive', 'Apple iCloud', 'pCloud' ];
Companies.forEach(c => {
  pool
	.query("SELECT AddCompany($1)", [ c ])
	.then(res => console.log('id: ', res))
	.catch(err =>  setImmediate(() => {
      throw err;
}))});
