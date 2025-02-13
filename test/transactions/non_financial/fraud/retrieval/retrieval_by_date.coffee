path  = require 'path'
_     = require 'underscore'
faker = require 'faker'

Base        = require '../../../base'
FakeConfig  = require path.resolve './test/transactions/fake_config'
Transaction =
  require path.resolve './src/genesis/transactions/non_financial/fraud/retrieval/retrieval_by_date'

describe 'RetrievalByDate Transaction', ->

  before ->
    @data =
      start_date:
        '2017-02-13'
      end_date:
        '2018-02-28'
      page:
        1

    @transaction = new Transaction(@data, FakeConfig.getConfig())

  context 'with invalid request', ->
    it 'fails when missing required start_date parameter', ->
      assert.isNotTrue @transaction.setData(_.omit @data, 'start_date').isValid()

    it 'fails when invalid start_date parameter format given', ->
      data = _.clone @data
      data.start_date = '13-09-2023'

      assert.isNotTrue @transaction.setData(data).isValid()

    it 'fails when invalid end_date parameter format given', ->
      data = _.clone @data
      data.end_date = '13-09-2023'

      assert.isNotTrue @transaction.setData(data).isValid()

    it 'fails when invalid import_date parameter format given', ->
      data = _.clone @data
      delete data.start_date
      delete data.end_date
      data.import_date = '13-09-2023'

      assert.isNotTrue @transaction.setData(data).isValid()

    it 'fails when invalid page parameter value given', ->
      data = _.clone @data
      data.page = 'NOT_VALID_VALUE'

      assert.isNotTrue @transaction.setData(data).isValid()

    it 'fails when invalid per_page parameter value given', ->
      data = _.clone @data
      data.per_page = 'NOT_VALID_VALUE'

      assert.isNotTrue @transaction.setData(data).isValid()

    it 'fails when invalid externally_processed parameter value given', ->
      data = _.clone @data
      data.externally_processed = 'NOT_VALID_VALUE'

      assert.isNotTrue @transaction.setData(data).isValid()

    it 'fails when invalid processing_type parameter value given', ->
      data = _.clone @data
      data.processing_type = 'NOT_VALID_VALUE'

      assert.isNotTrue @transaction.setData(data).isValid()

    it 'fails when start_date and import date are present', ->
      data = _.clone @data
      data.import_date = '2018-02-13'

      assert.isNotTrue @transaction.setData(data).isValid()

  context 'with valid request', ->
    it 'works with start_date parameters', ->
      data = _.clone @data

      data.per_page             = 20
      data.externally_processed = faker.random.arrayElement(
        ['genesis', 'external', 'all']
      )
      data.processing_type       = faker.random.arrayElement(
        ["card_present", "card_not_present", "all"]
      )

      assert.isTrue @transaction.setData(data).isValid()

    it 'works with import_date parameters', ->
      data = _.clone @data

      delete data.start_date
      delete data.end_date
      data.import_date          = '2020-06-17'
      data.per_page             = 20
      data.externally_processed = faker.random.arrayElement(
        ['genesis', 'external', 'all']
      )
      data.processing_type       = faker.random.arrayElement(
        ["card_present", "card_not_present", "all"]
      )

      assert.isTrue @transaction.setData(data).isValid()

  Base()
