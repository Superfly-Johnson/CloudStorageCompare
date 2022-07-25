// Dependencies
const express = require('express');
const morgan = require('morgan');
const fs = require('fs');
const path = require('path');

// Configuration
const config = require('./config.js');

//APplication
var app = express();

// Logger (morgan)
app.use(morgan('combined'));

// Routes that can't be iterated on
const uniqueRoutes = [ 'index' ];
// Routes
fs.readdir('./routes', function (err, files) {
    // Error handling
    if (err) {
        return console.log('Unable to scan directory: ' + err);
    }
    files.forEach(function (file) {
	name = path.parse(file).name
	if (file.endsWith(".js") && !(uniqueRoutes.includes(name))){
	    app.use(`/${name}`, require(`./routes/${name}`))
            console.log(file); 
	}
    });
});
const index = require('./routes/index.js');
app.use('/', index);

app.listen(3000, () => console.log(`Example app listening on port ${config.server.port}`));
