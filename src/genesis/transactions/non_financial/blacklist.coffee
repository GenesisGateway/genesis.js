
Request = require '../../request'

class Blacklist extends Request

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
