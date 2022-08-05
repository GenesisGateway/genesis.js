path    = require 'path'
_       = require 'underscore'
faker   = require 'faker'

Tokenization = () ->

  class TokenizationData
    @getValidRequest: (transactionData) ->
      data = _.extend(
        transactionData,
        {
          consumer_id: faker.datatype.number({max: 10}).toString(),
          token: faker.datatype.number({max: 36}).toString()
        }
      )

      delete data.card_number
      delete data.expiration_date
      delete data.expiration_year
      delete data.expiration_month
      delete data.cvv

      data

  context 'with Tokenization attributes', ->

    context 'with invalid parameters', ->

      it 'raise validation error with invalid remember_card', ->
        data               = TokenizationData.getValidRequest(_.clone @data)
        data.remember_card = 'true'

        assert.equal false, @transaction.setData(data).isValid()

      it 'raise validation error with invalid token', ->
        data       = TokenizationData.getValidRequest(_.clone @data)
        data.token = faker.datatype.number({min: 37})

        assert.equal false, @transaction.setData(data).isValid()

      it 'raise validation error with invalid consumer_id', ->
        data             = TokenizationData.getValidRequest(_.clone @data)
        data.consumer_id = faker.datatype.number({min: 11})

        assert.equal false, @transaction.setData(data).isValid()

    context 'with invalid request', ->

      it 'raise validation error with missing customer_email and present remember_card', ->
        data               = _.clone @data
        data.remember_card = true
        delete data.customer_email

        assert.equal false, @transaction.setData(data).isValid()

      it 'raise validation error with token and remember card', ->
        data               = TokenizationData.getValidRequest(_.clone @data)
        data.remember_card = true

        assert.equal false, @transaction.setData(data).isValid()

      it 'raise validation error with missing card_number and token', ->
        data = _.clone @data
        delete data.card_number

        assert.equal false, @transaction.setData(data).isValid()

      it 'raise validation error with missing customer_email', ->
        data = TokenizationData.getValidRequest(_.clone @data)
        delete data.customer_email

        assert.equal false, @transaction.setData(data).isValid()

      it 'raise validation error with missing consumer_id', ->
        data = TokenizationData.getValidRequest(_.clone @data)
        delete data.consumer_id

        assert.equal false, @transaction.setData(data).isValid()

    context 'with valid request', ->

      it 'should create consumer', ->
        data               = _.clone @data
        data.remember_card = true

        assert.equal true, @transaction.setData(data).isValid()

      it 'should send token data', ->
        data = TokenizationData.getValidRequest(_.clone(@data))

        assert.equal true, @transaction.setData(data).isValid()

module.exports = Tokenization
