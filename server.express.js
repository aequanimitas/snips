var express = require('express');
var webpack = require('webpack');
var WebpackDevServer = require('webpack-dev-server');
var fs = require('fs');
var app = express();

var config = require('./webpack.config');
var PORT = process.env.PORT || process.argv.slice(2)[0] || 3000;
var WPPORT = parseInt(PORT, 10) + 1;
var routes = {
  react: require('./routes/react')
};

app.use(express.static('dist'));
app.get('/', function(req, res) {
  var index = fs.readFileSync('./index.html', 'utf8');
  res.send(index);
});

app.use('/react', routes.react);

app.listen(PORT, function() {
  console.log('check localhost: ' + PORT);
});

// 
config.entry.unshift(
  'webpack/hot/dev-server',
  `webpack-dev-server/client?http://localhost:${WPPORT}`
);
config.plugins.push(new webpack.HotModuleReplacementPlugin());

var compiler = webpack(config);

var wpdServer = new WebpackDevServer(webpack(config), {
  hot: true, // is this redundant?
  proxy: {
    '*': 'http://localhost:' + PORT
  },
  stats: {
    colors: true
  }
});

wpdServer.listen(WPPORT);
