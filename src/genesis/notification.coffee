crypto      = require 'crypto'
config      = require 'config'
http        = require 'http'
util        = require 'util'
connect     = require 'connect'
xmlObj      = require 'xml-object'
bodyParser  = require 'body-parser'
Promise     = require 'bluebird'

Transaction = require './transaction'

class Notification

  constructor: ->
    @callbacks = { }
    @listener  = config.notifications

  ###
    Setup a listener for incoming notification requests
  ###
  listen: (onSuccess, onFailure) ->

    listener = connect()

    listener.use bodyParser.urlencoded { extended: true }

    listener.use @listener.path, (request, response) =>
      @handle(request, response)
        .then onSuccess
        .catch onFailure


    server = http.createServer listener
    server.listen @listener.port, @listener.host

    console.log(
      util.format '[notifier] listen on: %s:%s%s', @listener.host, @listener.port, @listener.path
    )

  ###
    Verify request and send reconcile
    @return Promise
  ###
  handle: (request, response) ->
    params        = request.body
    valid_request = @verifySignature params

    @output(params, response, valid_request)

    if valid_request then @reconcile params else Promise.reject 'Invalid Signature'

  output: (params, response, valid_request = true) ->
    response.setHeader(
      'Content-Type', 'text/xml'
    )

    if valid_request == false
      response.writeHead 400

    response.write(
      @echoConfirmation params
    )

    response.end ''

  ###
    Initiate a reconcile with Genesis Gateway
    @return Promise Returns transaction request promise
  ###
  reconcile: (params) ->
    transaction = new Transaction()

    reconcileParams =
      unique_id:
        params.wpf_unique_id || params.unique_id

    if @isWpfNotification(params)
      transaction.wpf_reconcile reconcileParams
        .send()
    else
      transaction.reconcile reconcileParams
        .send()

  ###
    Respond to Genesis as expected
    @return string Returns XML format expected from gateway
  ###
  echoConfirmation: (params) ->

    if @isWpfNotification(params)
      response_body = {
        notification_echo:
          'wpf_unique_id':
            params.wpf_unique_id
      }
    else
      response_body = {
        notification_echo:
          'unique_id':
            params.unique_id
      }

    return xmlObj response_body, declaration: true

  ###
    Verify an incoming request's signature
    @return boolean
  ###
  verifySignature: (params) ->
    if !params.signature
      return false

    if @isWpfNotification(params)
      unique_id = params.wpf_unique_id
    else
      unique_id = params.unique_id

    switch params.signature.length
      when 40  then hash = crypto.
                            createHash('sha1').
                            update(unique_id + config.customer.password).
                            digest('hex')
      when 64  then hash = crypto.
                            createHash('sha256').
                            update(unique_id + config.customer.password).
                            digest('hex')
      when 128 then hash = crypto.
                            createHash('sha512').
                            update(unique_id + config.customer.password).
                            digest('hex')
      else hash = new String

    if hash.toString() isnt params.signature.toString()
      return false

    true

  ###
    Check if request is WPF or Processing
  ###
  isWpfNotification: (params) ->
    if params.wpf_unique_id then return true

    return false

  getUrl: () =>
    util.format 'http://%s:%s%s'
    , @listener.host
    , @listener.port
    , @listener.path

module.exports = Notification
