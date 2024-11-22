_             = require 'underscore'
config        = require 'config'
BaseConfiguration = require './base_configuration'

class FileConfiguration extends BaseConfiguration

  constructor: () ->
    super()
    @configuration = config

  @getType: () ->
    'file'

module.exports = FileConfiguration
