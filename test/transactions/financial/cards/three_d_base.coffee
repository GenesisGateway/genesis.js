CardBase = require './card_base'
_        = require 'underscore'
faker    = require 'faker'

ThreeDBase = () ->

  CardBase()

  it 'fails when missing asynchronous required parameter and mpi_params', ->
    assert.equal false, @transaction.setData(
      _.omit @data, ['notification_url', 'mpi_params']
    ).isValid()

  it 'fails when mpi_params are set but eci is missing', ->
    delete @data['notification_url']
    delete @data['return_success_url']
    delete @data['return_failure_url']

    @data['mpi_params'] = {
      'cavv': faker.datatype.number().toString(),
      'xid':  faker.datatype.number().toString()
    }

    assert.equal false, @transaction.setData(@data).isValid()

  it 'works when 3DSv1 is set', ->
    data = _.clone @data
    delete data['notification_url']
    delete data['return_success_url']
    delete data['return_failure_url']

    data['mpi_params'] = {
      'eci': faker.datatype.number().toString(),
      'protocol_version': '1'
    }

    assert.equal true, @transaction.setData(data).isValid()

  it 'fails with invalid protocol_version', ->
    data = _.clone @data
    data['mpi_params'] = {
      'eci': faker.datatype.number().toString()
      'protocol_version': 'INVALID'
    }

    assert.equal false, @transaction.setData(data).isValid()

  it 'fails when is 3DSv2 without directory_server_id', ->
    data = _.clone @data
    data['mpi_params'] = {
      'eci': faker.datatype.number().toString()
      'protocol_version': "2"
    }

    assert.equal false, @transaction.setData(data).isValid()

  it 'works with 3DSv2 and directory_server_id', ->
    data = _.clone @data
    data['mpi_params'] = {
      'eci': faker.datatype.number().toString()
      'protocol_version': "2",
      'directory_server_id': faker.datatype.number().toString()
    }

    assert.equal true, @transaction.setData(data).isValid()

  it 'works synchronous when mpi_params are set', ->
    delete @data['notification_url']
    delete @data['return_success_url']
    delete @data['return_failure_url']

    @data['mpi_params'] = {
      'eci':  faker.datatype.number().toString(),
      'cavv': faker.datatype.number().toString(),
      'xid':  faker.datatype.number().toString()
    }

    assert.equal true, @transaction.setData(@data).isValid()

module.exports = ThreeDBase
