_ = require 'underscore'

class BaseConfiguration

  constructor: () ->
    @customer = {}
    @gateway = {}
    @notifications = {}

  getConfigObject: () ->
    @mapConfigObject()

# Customer
  setCustomer: (value) ->
    @customer = value

# Gateway
  setGateway: (value) ->
    @gateway = value

# Notifications
  setNotifications: (value) ->
    @notifications = value

  mapConfigObject: () ->
    configObject = {}

    if @configuration?.customer
      @setCustomer(@configuration.customer)
      configObject.customer = @customer

    if @configuration?.gateway
      @setGateway(@configuration.gateway)
      configObject.gateway = @gateway

    if @configuration?.notifications
      @setNotifications(@configuration.notifications)
      configObject.notifications = @notifications

    configObject

module.exports = BaseConfiguration
