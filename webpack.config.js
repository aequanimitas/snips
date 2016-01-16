var path = require('path');

module.exports = {
  entry: [
    './src/index.js'
  ],
  output: {
    filename: 'bundle.js',
    path: __dirname + '/dist',
    publicPath: '/dist/'
  },
  module: {
    loaders: [
      { test: /\.css$/, loader: "style!css" },
      { 
        test: /\.js$/, 
        loader: 'babel',
        exclude: /node_modules/,
        query: { presets: ['react', 'es2015'] }
       }
     ]
  },
  plugins: []
}
