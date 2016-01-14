var webpack = require('webpack');
var WebpackDevServer = require('webpack-dev-server');

var config = require('./webpack.config');

var PORT = process.env.PORT || process.argv.slice(2)[0] || 3000;

config.entry.unshift(
  'webpack/hot/dev-server',
  `webpack-dev-server/client?http://localhost:${PORT}`
);
config.plugins.push(new webpack.HotModuleReplacementPlugin());

var compiler = webpack(config);

var server = new WebpackDevServer(webpack(config), {
  hot: true, // is this redundant?
  stats: {
    colors: true
  }
});

server.listen(PORT);
