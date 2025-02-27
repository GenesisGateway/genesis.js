_     = require 'underscore'

ProcessedTransactionsByDate = ()  ->
  context 'with Processed Transactions by Date request', ->

    context 'with valid request', ->

      it 'works with all parameters', ->
        assert.isTrue @transaction.setData(@data).isValid()

    context 'with invalid request', ->

      it 'fails with missing required parameter', ->
        data = _.clone(@data)
        delete data.start_date
        assert.isNotTrue @transaction.setData(data).isValid()

      it 'fails with invalid externally_processed parameter', ->
        data = _.clone(@data)
        data.externally_processed = 'invalid_value'
        assert.isNotTrue @transaction.setData(data).isValid()

      it 'fails with invalid processing_type parameter', ->
        data = _.clone(@data)
        data.processing_type = 'invalid_value'
        assert.isNotTrue @transaction.setData(data).isValid()

      it 'fails with invalid date format', ->
        data = _.clone(@data)
        data.start_date = '21-12-2024'
        data.end_date = '21-12-2024'
        assert.isNotTrue @transaction.setData(data).isValid()

      it 'fails with invalid page parameter', ->
        data = _.clone(@data)
        data.page = 'invalid_value'
        assert.isNotTrue @transaction.setData(data).isValid()

      it 'fails with invalid per_page parameter', ->
        data = _.clone(@data)
        data.page = 'invalid_value'
        assert.isNotTrue @transaction.setData(data).isValid()

module.exports = ProcessedTransactionsByDate
