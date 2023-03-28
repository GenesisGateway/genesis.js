FinancialBase = require '../financial_base'
_             = require 'underscore'
Tokenization  = require '../../../examples/attributes/financial/tokenization'

CardBase = () ->

  context 'with Card Base', ->

    context 'with invalid request', ->

      it 'fails when missing required card_holder parameter', ->
        data = _.clone(@data)
        delete data.card_holder
        assert.equal false, @transaction.setData(data).isValid()

      it 'fails when missing required card_number parameter', ->
        data = _.clone(@data)
        delete data.card_number
        assert.equal false, @transaction.setData(data).isValid()

      it 'fails when wrong card_holder parameter', ->
        data = _.clone @data
        data.card_holder = 'NOT_VALID_CARD_HOLDER'
        assert.equal false, @transaction.setData(data).isValid()

      it 'fails when wrong card_number parameter', ->
        data = _.clone @data
        data.card_number = 'NOT_VALID_CARD_NUMBER'
        assert.equal false, @transaction.setData(data).isValid()

      it 'fails when wrong expiration_month parameter', ->
        data = _.clone @data
        data.expiration_month = 'NOT_VALID_EXPIRATION_MONTH'
        assert.equal false, @transaction.setData(data).isValid()

      it 'fails when wrong expiration_year parameter', ->
        data = _.clone @data
        data.expiration_year = 'NOT_VALID_EXPIRATION_YEAR'
        assert.equal false, @transaction.setData(data).isValid()

      it 'fails when wrong birth_date format given', ->
        data = _.clone @data
        data.birth_date = '01/01/2021'
        assert.equal false, @transaction.setData(data).isValid()

      it 'fail when wrong moto value given', ->
        data = _.clone @data
        data.moto = '111111111'
        assert.equal false, @transaction.setData(data).isValid()

      it 'fails when wrong birth_date format given', ->
        data = _.clone @data
        data.birth_date = '01/01/2021'
        assert.equal false, @transaction.setData(data).isValid()



    context 'with valid request', ->

      it 'not fails when right birth_date format given', ->
        data = _.clone @data
        data.birth_date = '01-01-2021'
        assert.equal true, @transaction.setData(data).isValid()

      it 'not fails when right birth_date format given', ->
        data = _.clone @data
        data.birth_date = '31-12-2021'
        assert.equal true, @transaction.setData(data).isValid()

      it 'not fails when day of birth_date is out of range', ->
        data = _.clone @data
        data.birth_date = '32-01-2021'
        assert.equal false, @transaction.setData(data).isValid()

      it 'not fails when month of birth_date is out of range', ->
        data = _.clone @data
        data.birth_date = '31-13-2021'
        assert.equal false, @transaction.setData(data).isValid()

      it 'not fails when right birth_date format given', ->
        data = _.clone @data
        data.birth_date = '31-12-2021'
        assert.equal true, @transaction.setData(data).isValid()

      it 'not fails when day of birth_date is out of range', ->
        data = _.clone @data
        data.birth_date = '32-01-2021'
        assert.equal false, @transaction.setData(data).isValid()

      it 'not fails when month of birth_date is out of range', ->
        data = _.clone @data
        data.birth_date = '31-13-2021'
        assert.equal false, @transaction.setData(data).isValid()

      it 'not fail with arabic card holder names', ->
        data = _.clone @data
        data.card_holder = 'جون سميث جون سميث'
        assert.equal true, @transaction.setData(data).isValid()

  FinancialBase()
  Tokenization()

module.exports = CardBase
