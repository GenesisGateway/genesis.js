faker = require 'faker'
_     = require 'underscore'

PurposeOfPayment = () ->

  it 'not fail with purpose_of_payment', ->
    data = _.clone @data
    purpose_of_payment = faker.random.arrayElement(
      [
        "ISINTE", "ISINTX", "ISINVS", "ISLBRI", "ISLICF", "ISLIFI", "ISLOAN", "ISMDCS",
        "ISMP2B", "ISMP2P", "ISMTUP", "ISNOWS", "ISOTHR", "ISOTLC", "ISPAYR", "ISPEFC",
        "ISPENS", "ISPHON", "ISPPTI", "ISRELG", "ISRENT", "ISRLWY", "ISROYA", "ISSALA",
        "ISSAVG", "ISSECU", "ISSSBE", "ISSTDY", "ISSUBS", "ISSUPP", "ISTAXR", "ISTAXS",
        "ISTBIL", "ISTRAD", "ISTREA", "ISTRPT", "ISUBIL", "ISVATX", "ISWHLD", "ISWTER"
      ]
    )
    data = _.extend(data, {'purpose_of_payment': purpose_of_payment})
    assert.equal true, @transaction.setData(data).isValid()

  it 'fail with invalid purpose_of_payment', ->
    data = _.clone @data
    data = _.extend(data, {'purpose_of_payment': 'invalid'})
    assert.equal false, @transaction.setData(data).isValid()

module.exports = PurposeOfPayment
