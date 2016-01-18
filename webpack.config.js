var path = require('path');
var webpack = require('webpack');

module.exports = {
  entry: [
    'webpack-hot-middleware/client',
    './src/index.js'
  ],
  output: {
    filename: 'bundle.js',
    path: __dirname + '/dist',
    publicPath: '/dist/'
  },
  module: {
    loaders: [
      { test: /\.css?$/, loader: "style!css" },
      { test: /\.js$/, loader: 'react-hot!babel', exclude: /node_modules/ },
      { test: /\.scss?/, loader: "style!css!sass" }
     ]
  },
  plugins: [
    new webpack.optimize.OccurenceOrderPlugin(),
    new webpack.HotModuleReplacementPlugin(),
    new webpack.NoErrorsPlugin()
  ]
}
