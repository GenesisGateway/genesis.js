faker = require 'faker'
_     = require 'underscore'

MpiParams = () ->
  class MpiParams
    context 'when mpi_params', ->
      beforeEach ->
        @mpi_data                                       = _.clone(@data)
        @mpi_data['mpi_params']['cavv']                 = faker.datatype.number().toString()
        @mpi_data['mpi_params']['eci']                  = faker.datatype.number().toString()
        @mpi_data['mpi_params']['xid']                  = faker.datatype.number().toString()
        @mpi_data['mpi_params']['protocol_version']     = '2'
        @mpi_data['mpi_params']['protocol_sub_version'] = '9'
        @mpi_data['mpi_params']['directory_server_id']  = faker.datatype.number().toString()
        @mpi_data['mpi_params']['acs_transaction_id']   = faker.datatype.number().toString()

        @transaction.setData(@mpi_data)

      it 'with valid request', ->
        assert.equal true, @transaction.isValid()

      it 'with invalid protocol_sub_version', ->
        invalid_data = _.extend(@mpi_data)

        invalid_data['mpi_params']['protocol_sub_version'] = "20"

        assert.equal false, @transaction.setData(@data).isValid()

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
