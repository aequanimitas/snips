var express = require('express');
var router = express.Router();

router.get('/', (req, res) => {
  res.send('Hi from angular');
});

module.exports = router;
