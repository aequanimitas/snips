var express = require('express');
var router = express.Router();

router.get('/', (req, res) => {
  res.send('Hi from react');
});

module.exports = router;
