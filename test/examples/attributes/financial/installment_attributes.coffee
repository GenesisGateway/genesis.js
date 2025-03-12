_     = require 'underscore'
faker = require 'faker'

InstallmentAttributes = () ->

  describe 'Installment Attributes', ->
    beforeEach ->
      @installmentData = _.clone @data
      @installmentData.installment_plan_id        = faker.datatype.uuid()
      @installmentData.installment_plan_reference = faker.datatype.uuid()

    it 'when installment attributes', ->
      assert.isTrue @transaction.setData(@installmentData).isValid()

    it 'without plan id', ->
      delete @installmentData.installment_plan_id

      assert.isTrue @transaction.setData(@installmentData).isValid()

    it 'without plan reference', ->
      delete @installmentData.installment_plan_reference

      assert.isTrue @transaction.setData(@installmentData).isValid()

module.exports = InstallmentAttributes
