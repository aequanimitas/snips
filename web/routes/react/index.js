var express = require('express');
var fs = require('fs');
var router = express.Router()
var path = require('path');

router.use(function logging(req, res, next) {
  console.log('entering react');
  next();
});

router.get('/', function(req, res) {
  var index = fs.readFileSync(path.join(__dirname, './index.html'), 'utf8');
  res.send(index);
});

module.exports = router;
