var path = require('path');

module.exports = {
  entry: [
    './app.js'
  ],
  output: {
    filename: './bundle.js',
    path: path.resolve(__dirname, 'build')
  },
  module: {
    loaders: [
      { test: /\.css$/, loader: "style-loader!css-loader" }
    ]
  },
  plugins: []
}
