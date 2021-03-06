const { environment } = require('@rails/webpacker')
const coffee =  require('./loaders/coffee')

environment.loaders.prepend('coffee', coffee)
module.exports = environment

const webpack = require('webpack')
environment.plugins.prepend('Provide',
  new webpack.ProvidePlugin({
    $: 'jquery/src/jquery',
    jQuery: 'jquery/src/jquery'
  })
)