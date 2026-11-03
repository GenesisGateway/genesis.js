faker = require 'faker'
_     = require 'underscore'

AccountOwnerAttributes = () ->

  it 'works with account_owner_attributes', ->
    data = _.clone @data
    data = _.extend(data, {
      account_owner: {
        first_name:  faker.random.alpha(35),
        middle_name:  faker.random.alpha(35),
        last_name:  faker.random.alpha(35)
      }
    })

    assert.equal true, @transaction.setData(data).isValid()

  it 'fails with over-length account_owner first_name', ->
    data = _.clone @data
    data = _.extend(data, {
      account_owner: {
        first_name:  faker.random.alpha(36)
      }
    })

    assert.equal false, @transaction.setData(data).isValid()

  it 'serializes account_owner as a nested object with only provided child fields', ->
    data = _.clone @data
    data = _.extend(data, {
      account_owner: {
        first_name: 'John',
        last_name:  'Smith'
      }
    })

    @transaction.setData(data)
    trx = @transaction.getTrxData()

    assert.equal trx.payment_transaction.account_owner.first_name, 'John'
    assert.equal trx.payment_transaction.account_owner.last_name, 'Smith'
    expect(trx.payment_transaction.account_owner).to.not.have.property('middle_name')

module.exports = AccountOwnerAttributes
