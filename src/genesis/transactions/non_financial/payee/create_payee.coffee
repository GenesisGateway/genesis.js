Request = require '../../../request'

###
  Create a Payee record
###
class CreatePayee extends Request

  constructor: (params, configuration) ->
    super(params, configuration, 'json')

  getTransactionType: ->
    'create_payee'

  getData: () ->
    @params

  getUrl: ->
    app:
      'smart_router'
    path:
      'payee'

  getTrxData: ->
    'payee':
      @params

module.exports = CreatePayee
