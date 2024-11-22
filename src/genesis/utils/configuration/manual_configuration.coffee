_ = require 'underscore'
Configuration = require './base_configuration'

class ManualConfiguration extends Configuration

  constructor: (@configuration) ->
    super()

  @getType: () ->
    'manual'

module.exports = ManualConfiguration
