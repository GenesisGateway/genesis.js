
Base = require '../base'

class Reconcile extends Base

  getTransactionType: ->
    'wpf_reconcile'

  getData: () ->
    @params

  getUrl: ->
    app:
      'wpf'
    path:
      'wpf/reconcile'

  getTrxData: ->
    'wpf_reconcile':
      @params

module.exports = Reconcile
