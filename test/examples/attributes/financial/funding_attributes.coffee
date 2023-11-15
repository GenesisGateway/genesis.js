faker = require 'faker'
_     = require 'underscore'

FundingAttributes = () ->

  it 'works with funding_attributes', ->
    data = _.clone @data
    data = _.extend(data, {
      funding: {
        identifier_type: faker.random.arrayElement([
          "general_person_to_person", "person_to_person_card_account", "own_account",
          "own_credit_card_bill", "business_disbursement",
          "government_or_non_profit_disbursement", "rapid_merchant_settlement",
          "general_business_to_business", "own_staged_digital_wallet_account",
          "own_debit_or_prepaid_card_account"
        ])
        receiver: {
          first_name:  faker.random.alpha(10),
          last_name:  faker.random.alpha(10),
          country: "AF",
          account_number: faker.datatype.number().toString(),
          account_number_type: faker.random.arrayElement([
            "rtn_and_bank_account_number", "iban", "card_account", "email", "phone_number",
            "bank_account_number_and_bic", "wallet_id", "social_network_id", "other"
            ])
        }
      }
    })

    assert.equal true, @transaction.setData(data).isValid()

  it 'fail with not existing identifier_type', ->
    data = _.clone @data
    data = _.extend(data, {
      funding: {
        identifier_type: "not_exists"
        receiver: {
          first_name:  faker.random.alpha(10),
          last_name:  faker.random.alpha(10),
          country: "AF",
          account_number: faker.datatype.number().toString(),
          account_number_type: faker.random.arrayElement([
            "rtn_and_bank_account_number", "iban", "card_account", "email", "phone_number",
            "bank_account_number_and_bic", "wallet_id", "social_network_id", "other"
          ])
        }
      }
    })

    assert.equal false, @transaction.setData(data).isValid()

module.exports = FundingAttributes
