_     = require 'underscore'
faker = require 'faker'
Types = require '../../../../src/genesis/helpers/transaction/types'

Tokenization = ()  ->

  context 'when invalid request', ->
    it 'fails without email parameter', ->
      data = _.clone(@data)
      delete data.email

      assert.isNotTrue @transaction.setData(data).isValid()

    it 'fails without token_type parameter', ->
      data = _.clone(@data)
      delete data.token_type

      assert.isNotTrue @transaction.setData(data).isValid()

    it 'fails without consumer_id parameter', ->
      data = _.clone(@data)
      delete data.consumer_id

      assert.isNotTrue @transaction.setData(data).isValid()

    it 'fails with invalid consumer_id', ->
      data = _.clone(@data)
      data.consumer_id = faker.random.alpha(11)

      assert.isNotTrue @transaction.setData(data).isValid()

  context 'when valid request', ->
    it 'works with string consumer_id', ->
      data = _.clone(@data)
      data.consumer_id = faker.random.alpha(10)

      assert.isTrue @transaction.setData(data).isValid()

  context 'when token parameter', ->
    it 'fails without token', ->
      @skip() if @transaction.getTransactionType() == Types.TOKENIZE

      data = _.clone(@data)
      delete data.token

      assert.isNotTrue @transaction.setData(data).isValid()

    it 'fails with invalid token', ->
      @skip() if @transaction.getTransactionType() == Types.TOKENIZE

      data = _.clone(@data)
      data.token = faker.random.alpha(37)

      assert.isNotTrue @transaction.setData(data).isValid()

module.exports = Tokenization
