faker = require 'faker'
_     = require 'underscore'

GiftCardAttributes = () ->

  describe 'Gift Card Attributes', ->
    beforeEach ->
      @giftCardData = _.clone @data
      @giftCardData.card_number = '1234567890987654321'
      @giftCardData.cvv         = '12345'
      @giftCardData.token       = faker.datatype.uuid()

    it 'with valid parameters', ->
      assert.isTrue @transaction.setData(@giftCardData).isValid()

    it 'when card_number with invalid value', ->
      @giftCardData.card_number = 'invalid'

      assert.isNotTrue @transaction.setData(@giftCardData).isValid()

    it 'when card_number with invalid short value', ->
      @giftCardData.card_number = '123456789098765432'

      assert.isNotTrue @transaction.setData(@giftCardData).isValid()

    it 'when card_number with invalid long value', ->
      @giftCardData.card_number = '1234567890987654321012'

      assert.isNotTrue @transaction.setData(@giftCardData).isValid()
    
    it 'when cvv with invalid value', ->
      @giftCardData.cvv = 'invalid'

      assert.isNotTrue @transaction.setData(@giftCardData).isValid()

    it 'when cvv with invalid short value', ->
      @giftCardData.cvv = '1234'

      assert.isNotTrue @transaction.setData(@giftCardData).isValid()

    it 'when cvv with invalid long value', ->
      @giftCardData.cvv = '123456789'

      assert.isNotTrue @transaction.setData(@giftCardData).isValid()

    it 'when token with invalid long value', ->
      @giftCardData.token = faker.datatype.uuid() + 'a'

      assert.isNotTrue @transaction.setData(@giftCardData).isValid()

module.exports = GiftCardAttributes
