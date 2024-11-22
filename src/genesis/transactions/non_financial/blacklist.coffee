
Base = require '../base'

class Blacklist extends Base

  constructor: (params, configuration) ->
    super params, configuration

  getTransactionType: ->
    'blacklist_request'

  getData: ->
    @params

  getUrl: ->
    app:
      'gate'
    path:
      'blacklists'

  getTrxData: ->
    "blacklist_request":
      @params

module.exports = Blacklist
