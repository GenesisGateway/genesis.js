path     = require 'path'
faker    = require 'faker'
_        = require 'underscore'
Currency = require path.resolve './src/genesis/helpers/currency'

class FakeData

  constructor: ->
    @data =
      _.extend(
        'transaction_id':
          faker.random.number()
        'currency':
          faker.random.arrayElement (new Currency).getCurrencies()
        'amount':
          faker.random.number()
        'usage':
          'Genesis JS Client Automated Request'
        'remote_ip':
          faker.internet.ip()
        'customer_email':
          faker.internet.email()
        'customer_phone':
          faker.phone.phoneNumber()
        ,
        @getCCData(),
        @getBillingData()
      )

  getCCData: ->
    'card_holder':
      faker.name.findName()
    'card_number':
      '4200000000000000'
    'cvv':
      faker.random.number({min: 100, max: 999}) #fix this to generate numbers like 003
    'expiration_month':
      faker.random.number({min: 1, max: 12})
    'expiration_year':
      faker.random.number({min: (new Date).getFullYear(), max: (new Date).getFullYear()+5})

  getBillingData: ->
    'billing_address':
      'first_name':
        faker.name.firstName()
      'last_name':
        faker.name.lastName()
      'address1':
        faker.address.streetAddress()
      'zip_code':
        faker.address.zipCode()
      'city':
        faker.address.city()
      'country':
        faker.address.countryCode()

  getData: ->
    @data

module.exports = FakeData