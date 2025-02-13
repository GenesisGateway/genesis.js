path  = require 'path'
_     = require 'underscore'
faker = require 'faker'

Base        = require '../../../base'
FakeConfig  = require path.resolve './test/transactions/fake_config'
Transaction = require(
  path.resolve './src/genesis/transactions/non_financial/fraud/reports/fraud_report_by_date'
)

describe 'FraudReportByDate Transaction', ->

  before ->
    @data =
      start_date:
        '2017-02-13'
      end_date:
        '2018-02-28'
      page:
        1

    @transaction = new Transaction(@data, FakeConfig.getConfig())

  context 'when invalid request', ->

    it 'fails with missing required start_date parameter', ->
      assert.isNotTrue @transaction.setData(_.omit @data, 'start_date').isValid()

    it 'fails with required start_date but missing end_date parameter', ->
      data = _.clone @data
      delete data.end_date
      assert.isNotTrue @transaction.setData(data).isValid()

    it 'fails with missing report_start_date', ->
      data = _.clone @data
      delete data.start_date
      delete data.end_date
      data.report_end_date = '2025-02-03'
      assert.isNotTrue @transaction.setData(data).isValid()

    it 'fails with required report_start_date but missing report_end_date parameter', ->
      data = _.clone @data
      delete data.start_date
      delete data.end_date
      data.report_start_date = '2025-02-03'
      assert.isNotTrue @transaction.setData(data).isValid()

    it 'fails with several required parameters', ->
      data = _.clone @data
      data.import = '2025-02-03'
      assert.isNotTrue @transaction.setData(data).isValid()

    it 'fails with invalid date format', ->
      data = _.clone @data
      data.import = '20-12-2024'
      assert.isNotTrue @transaction.setData(data).isValid()

  context 'when valid request', ->

    it 'works with start_date and end_date parameters', ->
      assert.isTrue @transaction.setData(@data).isValid()

    it 'works with import_date parameter', ->
      data = _.clone @data
      delete data.start_date
      delete data.end_date
      data.import_date = '2025-02-03'
      assert.isTrue @transaction.setData(data).isValid()

    it 'works with report_start_date and report_end_date parameters', ->
      data = _.clone @data
      delete data.start_date
      delete data.end_date
      data.report_start_date = '2025-02-03'
      data.report_end_date = '2025-03-03'
      assert.isTrue @transaction.setData(data).isValid()

  Base()
