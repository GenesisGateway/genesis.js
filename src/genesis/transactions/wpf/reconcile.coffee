
Request = require '../../request'

class Reconcile extends Request

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
