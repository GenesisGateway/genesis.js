process.env.NODE_CONFIG_DIR =
  if process.env.NODE_CONFIG_DIR
    process.env.NODE_CONFIG_DIR
  else require('path').join(__dirname, '..', 'config')

genesis =
  currency:      require './genesis/helpers/currency'
  notification:  require './genesis/notification'
  request:       require './genesis/request'
  transaction:   require './genesis/transaction'

module.exports = genesis
