crypto      = require 'crypto'
config      = require 'config'
http        = require 'http'
util        = require 'util'
connect     = require 'connect'
xmlObj      = require 'xml-object'
bodyParser  = require 'body-parser'

Transaction = require './transaction'

class Notification

  constructor: ->
    @callback = { }
    @listener = { }

  ###
    Setup a listener for incoming notification requests
  ###
  listen: (args, callback) ->

    @callback = callback

    @listener = args

    listener = connect()

    listener.use bodyParser.urlencoded { extended: true }

    listener.use args.path, (request, response) =>
      try
        params = request.body

        @verifySignature params

        @reconcile params, @callback

        response.setHeader(
          'Content-Type', 'text/xml'
        )
        response.write(
          @echoConfirmation params
        )
      catch Error
        response.writeHead 400

        console.error Error
      finally
        response.end ''

    http
      .createServer listener
      .listen args.port, args.host

    console.log(
      util.format '[notifier] listen on: %s:%s%s', args.host, args.port, args.path
    )

  ###
    Initiate a reconcile with Genesis Gateway

    If successful, it will initiate the callback with the body
  ###
  reconcile: (params, callback) ->

    success = (response, body) ->
      callback false, body

    failure = (error) ->
      callback error

    transaction = new Transaction()

    if params.wpf_unique_id
      transaction.wpf_reconcile {
        unique_id:
          params.wpf_unique_id
      }
      , success
      , failure
    else
      transaction.reconcile {
        unique_id:
          params.unique_id
      }
      , success
      , failure

  ###
    Respond to Genesis as expected
  ###
  echoConfirmation: (params) ->

    if params.wpf_unique_id
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
  ###
  verifySignature: (params) ->

    if params.unique_id
      unique_id = params.unique_id
    else if params.wpf_unique_id
      unique_id = params.wpf_unique_id
    else
      unique_id = new String

    switch params.signature.length
      when 40  then hash = crypto.
                            createHash('sha1').
                            update(unique_id + config.customer.password).
                            digest('hex')
      when 128 then hash = crypto.
                            createHash('sha512').
                            update(unique_id + config.customer.password).
                            digest('hex')
      else hash = new String

    if hash.toString() isnt params.signature.toString()
      throw new Error 'Invalid Signature'

  getUrl: () =>
    util.format 'http://%s:%s%s'
    , @listener.host
    , @listener.port
    , @listener.path

module.exports = Notification