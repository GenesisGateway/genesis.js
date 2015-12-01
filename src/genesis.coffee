process.env.NODE_CONFIG_DIR = if process.env.NODE_CONFIG_DIR then process.env.NODE_CONFIG_DIR else require('path').join(__dirname, '..', 'config')

config = require "config"

params =
  version: '1.0.0'

config.util.setModuleDefaults 'module', params

genesis = module.exports =
  currency:     require './genesis/currency'
  notification: require './genesis/notification'
  request:      require './genesis/request'
  transaction:  require './genesis/transaction'
