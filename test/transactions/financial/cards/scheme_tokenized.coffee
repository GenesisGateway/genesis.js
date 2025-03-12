_                = require 'underscore'
FakeData         = require '../../../transactions/fake_data'
path             = require('path')
TransactionTypes = require path.resolve './src/genesis/helpers/transaction/types'

skippableTransactionTypes = [
  TransactionTypes.AUTHORIZE,
  TransactionTypes.INIT_RECURRING_SALE,
  TransactionTypes.SALE
]

SchemeTokenized = () ->
  context 'Scheme Tokenized', ->

    context 'with valid request', ->
      it 'not fails when scheme_tokenized parameter set to false', ->
        data                  = _.clone(@data)
        data.scheme_tokenized = false
        assert.isTrue @transaction.setData(data).isValid()

      it 'not fails when scheme_tokenized parameter set to true', ->
        data                  = _.clone(@data)
        data.scheme_tokenized = true
        assert.isTrue @transaction.setData(data).isValid()

      it 'when not set document_server_id and scheme_tokenized parameter true', ->
        @skip() if @transaction.getTransactionType() in skippableTransactionTypes

        fakeData              = new FakeData()
        data                  = _.clone(@data)
        data['mpi_params']    = fakeData.getMpiParams().mpi_params
        data.scheme_tokenized = true
        delete data.mpi_params.directory_server_id
        assert.isTrue @transaction.setData(data).isValid()

    context 'with invalid request', ->
      it 'fails when missing document_server_id and scheme_tokenized parameter not set', ->
        @skip() if @transaction.getTransactionType() in skippableTransactionTypes

        fakeData           = new FakeData()
        data               = _.clone(@data)
        data['mpi_params'] = fakeData.getMpiParams().mpi_params
        delete data.mpi_params.directory_server_id
        delete data.scheme_tokenized
        assert.isNotTrue @transaction.setData(data).isValid()

module.exports = SchemeTokenized
