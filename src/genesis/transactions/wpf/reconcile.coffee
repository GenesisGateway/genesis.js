
Base = require '../base'

class Reconcile extends Base

  constructor: (params) ->
    super params

    @requiredFields = [
      'unique_id'
    ]

  getUrl: ->
    app:
      'gate'
    path:
      'wpf/reconcile'

  getTrxData: ->
    'wpf_reconcile':
      @params

module.exports = Reconcile