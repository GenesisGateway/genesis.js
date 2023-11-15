_        = require 'underscore'
{ XMLParser } = require 'fast-xml-parser'
Currency = require './helpers/currency'

class Response
  constructor: () ->
    @fastXmlParser = new XMLParser({ignoreDeclaration: true})
    @setUnderscoreMixins()

  ###
    Attempt to process response from Genesis Payment Gateway
  ###
  process: (response) ->
    _.chain(response.data)
      .response_parse(@fastXmlParser)
      .response_flatten()
      .response_convert_amount()
      .value()

  ###
    Add the processing steps as underscore.js mix-ins
  ###
  setUnderscoreMixins: () ->
    _.mixin

      # Parse the incoming XML document to JSON
      response_parse: (xml, fastXmlParser) ->
        return fastXmlParser.parse(xml)

      # Remove the firstChild as its usually just a single node
      response_flatten: (responseObject) ->
        return responseObject[_.first _.keys(responseObject)]

      # Convert the amount from ISO4217 to Nominal
      response_convert_amount: (responseObject) ->
        currency = new Currency()
        if responseObject != undefined
          if responseObject.hasOwnProperty('amount') and responseObject.hasOwnProperty('currency')
            responseObject.amount =
              currency.convertToNominalUnits responseObject.amount, responseObject.currency

        return responseObject

module.exports = Response
