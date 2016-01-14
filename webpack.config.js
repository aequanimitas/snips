var path = require('path');

module.exports = {
  entry: [
    './src/client.js'
  ],
  output: {
    filename: './bundle.js',
    path: path.resolve(__dirname, 'public')
  },
  module: {
    loaders: [
      { test: /\.css$/, loader: "style-loader!css-loader" }
    ]
  },
  plugins: []
}
