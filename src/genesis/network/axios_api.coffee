_              = require 'underscore'
util           = require 'util'
config         = require 'config'
axios          = require 'axios'
https          = require 'https'
BaseRequestApi = require './base_request_api'

Promise  = require 'bluebird'

class AxiosApi extends BaseRequestApi

  constructor: () ->
    super()

  request_query: (url, requestConfig, params) ->
    requestObject = Object.assign(
      {
        url: url
        data: params
      },
      requestConfig
    )

    @doRequest(axios, requestObject)

module.exports = AxiosApi
