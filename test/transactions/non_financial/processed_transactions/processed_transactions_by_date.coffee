path  = require 'path'
_     = require 'underscore'
faker = require 'faker'

Base           = require '../../base'
FakeConfig     = require path.resolve './test/transactions/fake_config'
SharedExamples = require '../../../examples/attributes/non-financial/processed_transactions_by_date'
Transaction    =
  require path.resolve './src/genesis/transactions/non_financial/processed_transactions/processed_transactions_by_date'

describe 'Processed Transactions By Date request', ->

  beforeEach ->
    @data = {
      start_date:           '2025-02-13'
      end_date:             '2025-02-14'
      page:                 faker.datatype.number(10)
      per_page:             faker.datatype.number(200)
      externally_processed: faker.random.arrayElement(['genesis', 'external', 'all'])
      processing_type:      faker.random.arrayElement(['card_present', 'card_not_present', 'all'])
    }
    @transaction = new Transaction(@data, FakeConfig.getConfig())

  it 'works with minimum required parameters', ->
    data = _.clone(@data)
    delete data.end_data
    delete data.page
    delete data.per_page
    delete data.externally_processed
    delete data.processing_type
    assert.isTrue @transaction.setData(data).isValid()

  SharedExamples()
  Base()
