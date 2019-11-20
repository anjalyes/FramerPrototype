'use strict';

var webpack = require('webpack');
var HtmlWebpackPlugin = require('html-webpack-plugin');

module.exports = {
  mode: 'development',
  context: __dirname + '/src/',
  devtool: 'source-map',
  entry: 'app.coffee',
  module: {
    rules: [
        {
          test: /\.coffee$/,
          loader: 'coffee-loader',
	  exclude: /(node_modules)/,
        },
        {
          test: /\.(coffee\.md|litcoffee)$/,
          loader: 'coffee-loader?literate',
	  exclude: /(node_module)/,
        },
    ],
  },
  output: {
    path: __dirname + '/build',
    filename: 'app.[hash].js',
  },
  plugins: [
    new HtmlWebpackPlugin({
      title: 'UX Framer Prototype',
      template: __dirname + '/src/index.html',
    }),
  ],
  resolve: {
    modules: [
        __dirname + '/src/',
        __dirname + '/src/app/modules/'],
    extensions: ['.web.coffee', '.web.js', '.coffee', '.js'],
  },
  resolveLoader: {
    modules: [
        __dirname + '/node_modules/',
    ],
  },
};