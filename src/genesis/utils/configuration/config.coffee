_ = require 'underscore'
FileConfiguration = require './file_configuration'
ManualConfiguration = require './manual_configuration'

class Config

  # Manual configuration identifier
  MANUAL: 'manual'
  # Version configuration identifier
  VERSION: '3.2.0'

  constructor: (@configuration) ->
    @initConfig()

  getConfig: () ->
    @config

  initConfig: ->
    switch @handleConfigType()
      when @MANUAL
        @config = (new ManualConfiguration @configuration).getConfigObject()
      else
        @config = (new FileConfiguration()).getConfigObject()

  handleConfigType: () ->
    if @configuration != null
      ManualConfiguration.getType()
    else
      FileConfiguration.getType()

  getCustomerUsername: () ->
    @getConfig().customer.username

  getCustomerPassword: () ->
    @getConfig().customer.password

  getCustomerToken:() ->
    @getConfig().customer.token

  getCustomerForceSmartRouter: ->
    @getConfig().customer.force_smart_routing || false

  getGatewayProtocol: () ->
    @getConfig().gateway.protocol || 'https'

  getGatewayHostname: () ->
    @getConfig().gateway.hostname

  getGatewayTimeout: () ->
    @getConfig().gateway.timeout || '60000'

  getGatewayTesting: () ->
    @getConfig().gateway.testing

  getNotificationHost: () ->
    @getConfig().notifications.host

  getNotificationPort: () ->
    @getConfig().notifications.port

  getNotificationPath: () ->
    @getConfig().notifications.path

  getNotifications: () ->
    @getConfig().notifications

  getVersion: ->
    @VERSION

module.exports = Config