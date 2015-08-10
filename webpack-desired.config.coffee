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

entryFiles = {}
for file in glob.sync('./scripts/*.{coffee,js}', cwd: config.app)
  entryFiles[path.basename(file ,path.extname(file))] = file

commonsEntries = (
  chunkName for chunkName, filePath of entryFiles when chunkName != 'vendor')

loaderExclude = /node_modules|bower_components/

sassLoaders = [
  "css-loader?sourceMap"
  "autoprefixer-loader?browsers=last 1 version"
  "sass-loader?sourceMap&includePaths[]=" + path.resolve(__dirname, "./src")
].join('!')

module.exports =
  context: config.app
  entry: entryFiles
  output:
    path: config.dist
    filename: './scripts/[name]-[hash].js'
  devtool: 'source-map'
  module:
    loaders: [
      { test: /\.coffee$/,  loader: "coffee", exclude: loaderExclude }
      { test: /\.jade$/,    loader: "jade",   exclude: loaderExclude }
      { test: /\.scss$/,    loader: ExtractTextPlugin.extract(sassLoaders)}
    ]
  plugins: [
    new Clean(['dist'])
    new NgAnnotatePlugin({add:true})
    new ExtractTextPlugin("styles/[name]-[hash].css")
    new webpack.ResolverPlugin(new webpack.ResolverPlugin.DirectoryDescriptionFilePlugin("bower.json", ["main"]))
    new webpack.optimize.CommonsChunkPlugin(name: "vendor", filename: "./scripts/vendor-[hash].js", minChunks: Infinity)
    new webpack.optimize.CommonsChunkPlugin(name: 'common', filename: './scripts/common-[hash].js', chunks: commonsEntries)
    new webpack.optimize.DedupePlugin()
    new HtmlWebpackPlugin template: path.join(config.app, 'index.html')
  ]
  resolve:
    root:               [path.join(config.app, "scripts")]
    extensions:         ["", ".coffee", ".js", ".jade", ".scss"]
    modulesDirectories: ["node_modules", "bower_components"]
