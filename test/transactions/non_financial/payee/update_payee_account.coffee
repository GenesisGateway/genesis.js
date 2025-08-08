BaseExamples    = require '../../base'
faker           = require 'faker'
_               = require 'underscore'
FakeConfig      = require '../../fake_config'
FakeData        = require '../../fake_data'
Transaction     = require '../../../../src/genesis/transactions/non_financial/payee/update_payeee_account'

describe 'Update Payee Transaction', ->

  beforeEach ->
    fakeData                = new FakeData()
    @data                   = {}
    @data.payee_unique_id   = faker.datatype.uuid()
    @data.account_unique_id = faker.datatype.uuid()
    @data.account           = {}
    @data.account.country   = faker.address.countryCode()

    @transaction = new Transaction(@data, FakeConfig.getConfig())

  context 'when valid request', ->

    it 'with all parameters', ->
      assert.isTrue @transaction.setData(@data).isValid()

  context 'when invalid request', ->
    it 'fails when payee_unique_id is missing', ->
      data = _.clone @data
      delete data['payee_unique_id']
      assert.isFalse @transaction.setData(data).isValid()

    it 'fails when account_unique_id is missing', ->
      data = _.clone @data
      delete data['account_unique_id']
      assert.isFalse @transaction.setData(data).isValid()

    it 'fails with invalid country', ->
      data = _.clone @data
      data['payee_country'] = 'zz'
      assert.isFalse @transaction.setData(data).isValid()

  context 'when testing specific methods', ->
    it 'correctly constructs the API URL', ->
      @transaction.setData(@data)
      url = @transaction.getUrl()
      assert.deepEqual url,
        app: 'smart_router'
        path: "payee/#{@data.payee_unique_id}/account/#{@data.account_unique_id}"

    it 'removes payee_unique_id from request parameters', ->
      @transaction.setData(@data)
      requestParams = @transaction.getTrxData()
      assert.isUndefined requestParams.payee_unique_id

    it 'removes account_unique_id from request parameters', ->
      @transaction.setData(@data)
      requestParams = @transaction.getTrxData()
      assert.isUndefined requestParams.account_unique_id

    it 'populates the payee_unique_id property', ->
      @transaction.setData(@data)
      assert.equal @transaction.payee_unique_id, @data.payee_unique_id

    it 'populates the account_unique_id property', ->
      @transaction.setData(@data)
      assert.equal @transaction.account_unique_id, @data.account_unique_id

    it 'with patch builder interface', ->
      assert.equal @transaction.builderInterface, 'patch'

  BaseExamples()
