var express = require('express');
var routes = require('./routes');

var app = express();
var port = 12000;

app.use('/', routes);

app.listen(port, () => {
  console.log('Running..');
});
