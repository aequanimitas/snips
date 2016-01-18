var express = require('express');
var webpackDevMiddleware = require('webpack-dev-middleware');
var webpackHotMiddleware = require('webpack-hot-middleware');
var webpack = require('webpack');
var config = require('./webpack.config');
var app = express();
var compiler = webpack(config);

app.use(webpackDevMiddleware(compiler, {
  noInfo: true, stats: { colors: true }, publicPath: config.output.publicPath
}));

app.use(webpackHotMiddleware(compiler));

app.get('/', function(req, res) {
  res.sendFile(__dirname + '/index.html');
});

app.listen(process.env.PORT || 3000);
