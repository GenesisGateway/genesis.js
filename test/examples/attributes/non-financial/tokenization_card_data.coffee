_     = require 'underscore'
faker = require 'faker'

TokenizationCardData = ()  ->

  context 'when invalid card data', ->
    it 'fails without card_data parameters', ->
      data = _.clone(@data)

      delete data.card_data

      assert.isNotTrue @transaction.setData(data).isValid()

    it 'fails without card_number parameter', ->
      data = _.clone(@data)

      delete data.card_data.card_number

      assert.isNotTrue @transaction.setData(data).isValid()

  context 'when valid card data', ->
    it 'works without optional params', ->
      data = _.clone(@data)

      delete data.card_data.card_holder
      delete data.card_data.expiration_year
      delete data.card_data.expiration_month

      assert.isTrue @transaction.setData(data).isValid()


module.exports = TokenizationCardData
