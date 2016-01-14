var express = require('express');
var fs = require('fs');
var app = express();

var PORT = process.env.PORT || process.argv.slice(2)[0] || 3000;

var router = express.Router();

app.get('/', function(req, res) {
  var index = fs.readFileSync('./index.html', 'utf8');
  res.send(index);
});

app.listen(PORT, function() {
  console.log('check localhost: ' + PORT);
});
