faker = require 'faker'
_     = require 'underscore'

CredentialOnFile = () ->

  it 'works with credential on file parameter', ->
    data = _.clone @data
    data = _.extend(data,
      {
        credential_on_file: faker.random.arrayElement(
          ['initial_customer_initiated', 'subsequent_customer_initiated', 'merchant_unscheduled']
        )
      }
    )

    assert.equal true, @transaction.setData(data).isValid()

  it 'works without credential on file parameter', ->
    data = _.clone @data
    delete data.credential_on_file

    assert.equal true, @transaction.setData(data).isValid()

  it 'fails with invalid credential on file parameter', ->
    data = _.clone @data
    data.credential_on_file = "INVALID_VALUE"

    assert.equal false, @transaction.setData(data).isValid()

module.exports = CredentialOnFile
