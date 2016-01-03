var express = require('express');
var router = express.Router();
var reactSnippets = require('./react');
var angularSnippets = require('./angular');

router.use('/', reactSnippets);
router.use('/react', reactSnippets);
router.use('/angular', angularSnippets);

module.exports = router;
