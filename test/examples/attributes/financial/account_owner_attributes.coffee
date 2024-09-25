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

module.exports = AccountOwnerAttributes
