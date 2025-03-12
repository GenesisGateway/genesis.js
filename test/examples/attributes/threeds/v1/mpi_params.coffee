_        = require 'underscore'
FakeData = require '../../../../transactions/fake_data'

MpiParams = () ->
  class MpiParams
    context 'when mpi_params', ->
      beforeEach ->
        fakeData  = new FakeData()
        @mpi_data = _.clone(@data)
        delete @mpi_data.notification_url
        delete @mpi_data.return_success_url
        delete @mpi_data.return_failure_url

        @mpi_data['mpi_params'] = fakeData.getMpiParams().mpi_params

        @transaction.setData(@mpi_data)

      it 'with valid request', ->
        assert.isTrue @transaction.isValid()

      it 'with invalid protocol_sub_version', ->
        invalid_data = _.extend(@mpi_data)

        invalid_data['mpi_params']['protocol_sub_version'] = "20"

        assert.isNotTrue @transaction.setData(invalid_data).isValid()

      it 'with non empty cavv', ->
        assert.isNotEmpty @transaction.getTrxData().payment_transaction.mpi_params.cavv

      it 'with non empty eci', ->
        assert.isNotEmpty @transaction.getTrxData().payment_transaction.mpi_params.eci

      it 'with non empty xid', ->
        assert.isNotEmpty @transaction.getTrxData().payment_transaction.mpi_params.xid

      it 'with non empty protocol_version', ->
        assert.isNotEmpty @transaction.getTrxData().payment_transaction.mpi_params.protocol_version

      it 'with non empty protocol_sub_version', ->
        assert.isNotEmpty @transaction.getTrxData().payment_transaction.mpi_params.protocol_sub_version

      it 'with non empty directory_server_id', ->
        assert.isNotEmpty @transaction.getTrxData().payment_transaction.mpi_params.directory_server_id

      it 'with non empty acs_transaction_id', ->
        assert.isNotEmpty @transaction.getTrxData().payment_transaction.mpi_params.acs_transaction_id

module.exports = MpiParams
