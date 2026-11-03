_     = require 'underscore'

ForceThreeds = () ->
  describe 'Force Threeds', ->

    it 'works when force_threeds set to true', ->
      data               = _.clone(@data)
      data.force_threeds = true

      assert.isTrue @transaction.setData(data).isValid()

    it 'works when force_threeds set to false', ->
      data               = _.clone(@data)
      data.force_threeds = false

      assert.isTrue @transaction.setData(data).isValid()

    it 'works when force_threeds is omitted', ->
      data = _.clone(@data)
      delete data.force_threeds

      assert.isTrue @transaction.setData(data).isValid()

    it 'fails when force_threeds is a non-boolean value', ->
      data               = _.clone(@data)
      data.force_threeds = 'true'

      assert.isNotTrue @transaction.setData(data).isValid()

    it 'with force_threeds in request parameters when set', ->
      data               = _.clone(@data)
      data.force_threeds = true

      @transaction.setData(data)

      expect(@transaction.getArguments().trx.payment_transaction)
        .to.have.nested.property('force_threeds')

    it 'without force_threeds in request parameters when omitted', ->
      data = _.clone(@data)
      delete data.force_threeds

      @transaction.setData(data)

      expect(@transaction.getArguments().trx.payment_transaction)
        .to.not.have.nested.property('force_threeds')

module.exports = ForceThreeds
