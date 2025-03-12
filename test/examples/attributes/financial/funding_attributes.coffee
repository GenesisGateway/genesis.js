_        = require 'underscore'
FakeData = require '../../../transactions/fake_data'

FundingAttributes = () ->

  describe 'Funding Attributes', ->
    beforeEach ->
      @fundingData = _.clone @data
      @fundingData = _.extend @fundingData, (new FakeData).getFundingData()

    it 'works with funding_attributes', ->
      assert.isTrue @transaction.setData(@fundingData).isValid()

    it 'fail with invalid identifier_type', ->
      @fundingData.funding.identifier_type = 'invalid'

      assert.isNotTrue @transaction.setData(@fundingData).isValid()

    it 'fail with invalid business_application_identifier', ->
      @fundingData.funding.business_application_identifier = 'invalid'

      assert.isNotTrue @transaction.setData(@fundingData).isValid()

    it 'fail with invalid account_number_type', ->
      @fundingData.funding.receiver.account_number_type = 'invalid'

      assert.isNotTrue @transaction.setData(@fundingData).isValid()

    it 'fail when funding node with additional properties', ->
      @fundingData.funding.element = 'value'

      assert.isNotTrue @transaction.setData(@fundingData).isValid()

    it 'fail when funding receiver node with additional properties', ->
      @fundingData.funding.receiver.element = 'value'

      assert.isNotTrue @transaction.setData(@fundingData).isValid()

    it 'fail when funding sender node with addtional properties', ->
      @fundingData.funding.sender.element = 'value'

      assert.isNotTrue @transaction.setData(@fundingData).isValid()

    it 'fail when funding receiver country with invalid value', ->
      @fundingData.funding.receiver.country = 'invalid'

      assert.isNotTrue @transaction.setData(@fundingData).isValid()

    it 'fail when funding sender country with invalid value', ->
      @fundingData.funding.sender.country = 'invalid'

      assert.isNotTrue @transaction.setData(@fundingData).isValid()

module.exports = FundingAttributes
