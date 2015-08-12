path              = require 'path'
glob              = require "glob"
webpack           = require "webpack"
NgAnnotatePlugin  = require 'ng-annotate-webpack-plugin'
HtmlWebpackPlugin = require 'html-webpack-plugin'
Clean             = require 'clean-webpack-plugin'
ExtractTextPlugin = require "extract-text-webpack-plugin"

config =
  app:  path.join(process.cwd(), 'app')
  dist: path.join(process.cwd(), 'dist')

config.images = path.join(config.app, "images")

module.exports =
  context: config.app
  entry: "scripts/image.coffee"
  output:
    path: config.dist
    filename: './scripts/[name]-[chunkhash].js'
  devtool: 'eval-source-map'
  module:
    loaders: [
      { test: /\.coffee$/,  loader: "coffee", include: config.scripts }
      { test: /\.html$/,    loader: "html",   include: config.scripts }
      { test: /\.(jpg|png)$/, loader: "url",  include: config.images}
    ]
  resolve:
    root:               config.app
    extensions:         ["", ".coffee", ".js", ".jade"]
    modulesDirectories: ["node_modules", "bower_components", "scripts", "images"]
    alias: {images: config.images }

  watchOptions:
    poll: true
