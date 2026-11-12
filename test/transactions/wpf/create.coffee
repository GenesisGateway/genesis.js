path  = require 'path'
_     = require 'underscore'
faker = require 'faker'

BusinessAttributes            = require '../business_attributes'
DigitalAssetTypes             = require '../../examples/attributes/digital_asset_types'
DynamicDescriptor             = require '../../examples/attributes/financial/dynamic_descriptor'
DynamicDescriptorMerchantName = require '../../examples/attributes/financial/dynamic_descriptor_merchant_name'
FakeConfig                    = require '../fake_config'
FakeData                      = require '../fake_data'
FinancialBase                 = require '../financial/financial_base'
FundingAttributes             = require '../../examples/attributes/financial/funding_attributes'
i18n                          = require path.resolve 'src/genesis/helpers/i18n'
PayLater                      = require '../../examples/attributes/pay_later'
Transaction                   = require path.resolve './src/genesis/transactions/wpf/create'


describe 'WPFCreate Transaction', ->

  beforeEach ->
    @data        = (new FakeData).getSimpleDataAndBusinessAttributes()

    @transaction = new Transaction(@data, FakeConfig.getConfig())

    delete @data.remote_ip
    @data['transaction_types']  = [
      'sale',
      'authorize'
    ]
    @data['locale']             = faker.random.arrayElement((new i18n).getLocales())
    @data['notification_url']   = faker.internet.url()
    @data['return_success_url'] = faker.internet.url()
    @data['return_failure_url'] = faker.internet.url()
    @data['return_cancel_url']  = faker.internet.url()

  it 'fails when missing required transaction_types parameter', ->
    assert.equal false, @transaction.setData(_.omit @data, 'transaction_types').isValid()

  it 'fails when wrong transaction_type', ->
    data = _.clone @data
    data.transaction_types = [
      {
        NOT_VALID_TYPE:{}
      }
    ]
    assert.equal false, @transaction.setData(data).isValid()

  it 'works when transaction_type exists', ->
    data = _.clone @data
    data.transaction_types = [
      {
        authorize: {
          bin: '123456'
        }
      },
      'sale'
    ]
    assert.equal true, @transaction.setData(data).isValid()

  it 'works when custom attribute of transaction_type exists', ->
    data = _.clone @data
    data.transaction_types = [
      {
        authorize: {
          bin: "123456"
        }
      }
    ]
    assert.equal true, @transaction.setData(data).isValid()

  it 'fails when custom attribute of transaction_type not exists', ->
    data = _.clone @data
    data.transaction_types = [
      {
        authorize: {
          NOT_VALiD_CUSTOM_ATTRIBUTE: "1111111111"
        }
      }
    ]
    assert.equal false, @transaction.setData(data).isValid()

  it 'fails when wrong type of custom attribute ', ->
    data = _.clone @data
    data.transaction_types = [
      {
        authorize: {
          bin: 111
        }
      }
    ]
    assert.equal false, @transaction.setData(data).isValid()

  it 'fails when wrong length of bin custom attribute ', ->
    data = _.clone @data
    data.transaction_types = [
      {
        authorize: {
          bin: "12345"
        }
      }
    ]
    assert.equal false, @transaction.setData(data).isValid()

  it 'fails when wrong format of custom attribute expiration_date', ->
    data = _.clone @data
    data.transaction_types = [
      {
        authorize: {
          expiration_date: "10-2020"
        }
      }
    ]
    assert.equal false, @transaction.setData(data).isValid()

  it 'works with correct format of custom attribute expiration_date', ->
    data = _.clone @data
    data.transaction_types = [
      {
        authorize: {
          expiration_date: "2020-10"
        }
      }
    ]
    assert.equal true, @transaction.setData(data).isValid()

  it 'fails when missing required parameter crypto_wallet_provider of bitpay custom attribute', ->
    data = _.clone @data
    data.transaction_types = [
      {
        bitpay_payout: {
          crypto_address: "CRYPTO_ADDRESS"
        }
      }
    ]
    assert.equal false, @transaction.setData(data).isValid()

  it 'works when all required custom attributes of bitpay are set', ->
    data = _.clone @data
    data.transaction_types = [
      {
        bitpay_payout: {
          crypto_address: "CRYPTO_ADDRESS",
          crypto_wallet_provider: "CRYPTO_WALLET_PROVIDER"
        }
      }
    ]
    assert.equal true, @transaction.setData(data).isValid()

  it 'fails when unsupported payment_type was set to google_pay custom attribute', ->
    data = _.clone @data
    data.transaction_types = [
      {
        google_pay: {
          payment_subtype: "NOT_VALID_PAYMENT_TYPE"
        }
      }
    ]
    assert.equal false, @transaction.setData(data).isValid()

  it 'works when supported payment_subtype was set to google_pay custom attribute', ->
    data = _.clone @data
    data.transaction_types = [
      {
        google_pay: {
          payment_subtype: "authorize"
        }
      }
    ]
    assert.equal true, @transaction.setData(data).isValid()

  it 'works with correct online_banking structure', ->
    data = _.clone @data
    data.transaction_types = [
      {
        online_banking: {
          bank_codes: [
            {
              bank_code: ["bank_1", "bank_2"]
            }
          ]
        }
      }
    ]
    assert.equal true, @transaction.setData(data).isValid()

  it 'works when authorize without managed_recurring included', ->
    data = _.clone @data
    data['currency'] = 'EUR'
    data.transaction_types = [
      {
        authorize: {
          bin: "123456",
        }
      }
    ]

    assert.equal true, @transaction.setData(data).isValid()

  it 'works when authorize with managed_recurring attribute included', ->
    data = _.clone @data
    data['currency'] = 'EUR'
    data.transaction_types = [
      {
        authorize: {
          bin: "123456",
          managed_recurring: {
            mode: "automatic"
            amount: 500
          }
        }
      }
    ]

    assert.equal true, @transaction.setData(data).isValid()

  it 'works when authorize3d with managed_recurring attribute included', ->
    data = _.clone @data
    data['currency'] = 'EUR'
    data.transaction_types = [
      {
        authorize3d: {
          bin: "123456",
          managed_recurring: {
            mode: "automatic"
            amount: 500
          }
        }
      }
    ]

    assert.equal true, @transaction.setData(data).isValid()

  it 'works when sale with managed_recurring attribute included', ->
    data = _.clone @data
    data['currency'] = 'EUR'
    data.transaction_types = [
      {
        sale: {
          bin: "123456",
          managed_recurring: {
            mode: "manual"
            amount: 500
          }
        }
      }
    ]

    assert.equal true, @transaction.setData(data).isValid()

  it 'works when sale3d with managed_recurring attribute included', ->
    data = _.clone @data
    data['currency'] = 'EUR'
    data.transaction_types = [
      {
        sale3d: {
          bin: "123456",
          managed_recurring: {
            mode: "automatic"
            amount: 500
          }
        }
      }
    ]

    assert.equal true, @transaction.setData(data).isValid()

  it 'works when init_recurring_sale with managed_recurring attribute included', ->
    data = _.clone @data
    data['currency'] = 'EUR'
    data.transaction_types = [
      {
        init_recurring_sale: {
          bin: "123456",
          managed_recurring: {
            mode: "manual",
            amount: "500"
          }
        }
      }
    ]

    assert.equal true, @transaction.setData(data).isValid()

  it 'works when init_recurring_sale3d with managed_recurring attribute included', ->
    data = _.clone @data
    data['currency'] = 'EUR'
    data.transaction_types = [
      {
        init_recurring_sale3d: {
          bin: "123456",
          managed_recurring: {
            mode: "manual"
            amount: "500"
          }
        }
      }
    ]

    assert.equal true, @transaction.setData(data).isValid()

  it 'works when object transaction type without managed_recurring property', ->
    data = _.clone @data
    data['currency'] = 'EUR'
    data.transaction_types = [
      {
        authorize3d: {
          bin: "123456"
        }
      }
    ]

    @transaction.setData(data)
    trx = @transaction.getTrxData()

    expect(trx).not.to.have.nested.property(
      'wpf_payment.transaction_types.transaction_type[0].managed_recurring'
    )

  it 'works when authorize with recurring_type attribute included', ->
    data = _.clone @data
    data.transaction_types = [
      {
        authorize: {
          recurring_type: "initial"
        }
      }
    ]

    assert.equal true, @transaction.setData(data).isValid()

  context 'Covert to minor currency', ->

    context 'managed_recurring attribute with amount', ->

      it 'works with authoirze', ->
        data = _.clone @data
        data['currency'] = 'EUR'
        data.transaction_types = [
          {
            authorize: {
              bin: "123456",
              managed_recurring: {
                mode: "manual"
                amount: 1.23
              }
            }
          }
        ]

        @transaction.setData(data)
        trx = @transaction.getTrxData()

        assert.equal(
          trx.wpf_payment.transaction_types.transaction_type[0].managed_recurring.amount, 123
        )

      it 'works with authoirze3d', ->
        data = _.clone @data
        data['currency'] = 'EUR'
        data.transaction_types = [
          {
            authorize3d: {
              bin: "123456",
              managed_recurring: {
                mode: "manual"
                amount: 1.23
              }
            }
          }
        ]

        @transaction.setData(data)
        trx = @transaction.getTrxData()

        assert.equal(
          trx.wpf_payment.transaction_types.transaction_type[0].managed_recurring.amount, 123
        )

      it 'works with sale', ->
        data = _.clone @data
        data['currency'] = 'EUR'
        data.transaction_types = [
          {
            sale: {
              bin: "123456",
              managed_recurring: {
                mode: "manual"
                amount: 1.23
              }
            }
          }
        ]

        @transaction.setData(data)
        trx = @transaction.getTrxData()

        assert.equal(
          trx.wpf_payment.transaction_types.transaction_type[0].managed_recurring.amount, 123
        )

      it 'works with sale3d', ->
        data = _.clone @data
        data['currency'] = 'EUR'
        data.transaction_types = [
          {
            sale3d: {
              bin: "123456",
              managed_recurring: {
                mode: "manual"
                amount: 1.23
              }
            }
          }
        ]

        @transaction.setData(data)
        trx = @transaction.getTrxData()

        assert.equal(
          trx.wpf_payment.transaction_types.transaction_type[0].managed_recurring.amount, 123
        )

      it 'works with init_recurring_sale', ->
        data = _.clone @data
        data['currency'] = 'EUR'
        data.transaction_types = [
          {
            init_recurring_sale: {
              bin: "123456",
              managed_recurring: {
                mode: "manual"
                amount: 1.23
              }
            }
          }
        ]

        @transaction.setData(data)
        trx = @transaction.getTrxData()

        assert.equal(
          trx.wpf_payment.transaction_types.transaction_type[0].managed_recurring.amount, 123
        )

      it 'works with init_recurring_sale3d', ->
        data = _.clone @data
        data['currency'] = 'EUR'
        data.transaction_types = [
          {
            init_recurring_sale3d: {
              bin: "123456",
              managed_recurring: {
                mode: "manual"
                amount: 1.23
              }
            }
          }
        ]

        @transaction.setData(data)
        trx = @transaction.getTrxData()

        assert.equal(
          trx.wpf_payment.transaction_types.transaction_type[0].managed_recurring.amount, 123
        )

    context 'managed_recurring attribute with max_amount', ->

      it 'works with authoirze', ->
        data = _.clone @data
        data['currency'] = 'EUR'
        data.transaction_types = [
          {
            authorize: {
              bin: "123456",
              managed_recurring: {
                mode: "manual"
                amount: 1.11
              }
            }
          }
        ]

        @transaction.setData(data)
        trx = @transaction.getTrxData()

        assert.equal(
          trx.wpf_payment.transaction_types.transaction_type[0].managed_recurring.amount, 111
        )

      it 'works with authoirze3d', ->
        data = _.clone @data
        data['currency'] = 'EUR'
        data.transaction_types = [
          {
            authorize3d: {
              bin: "123456",
              managed_recurring: {
                mode: "manual"
                max_amount: 1.23
              }
            }
          }
        ]

        @transaction.setData(data)
        trx = @transaction.getTrxData()

        assert.equal(
          trx.wpf_payment.transaction_types.transaction_type[0].managed_recurring.max_amount, 123
        )

      it 'works with sale', ->
        data = _.clone @data
        data['currency'] = 'EUR'
        data.transaction_types = [
          {
            sale: {
              bin: "123456",
              managed_recurring: {
                mode: "manual"
                max_amount: 1.11
              }
            }
          }
        ]

        @transaction.setData(data)
        trx = @transaction.getTrxData()

        assert.equal(
          trx.wpf_payment.transaction_types.transaction_type[0].managed_recurring.max_amount, 111
        )

      it 'works with sale3d', ->
        data = _.clone @data
        data['currency'] = 'EUR'
        data.transaction_types = [
          {
            sale3d: {
              bin: "123456",
              managed_recurring: {
                mode: "manual"
                max_amount: 1.11
              }
            }
          }
        ]

        @transaction.setData(data)
        trx = @transaction.getTrxData()

        assert.equal(
          trx.wpf_payment.transaction_types.transaction_type[0].managed_recurring.max_amount, 111
        )

      it 'works with init_recurring_sale', ->
        data = _.clone @data
        data['currency'] = 'EUR'
        data.transaction_types = [
          {
            init_recurring_sale: {
              bin: "123456",
              managed_recurring: {
                mode: "manual"
                max_amount: 1.11
              }
            }
          }
        ]

        @transaction.setData(data)
        trx = @transaction.getTrxData()

        assert.equal(
          trx.wpf_payment.transaction_types.transaction_type[0].managed_recurring.max_amount, 111
        )

      it 'works with init_recurring_sale3d', ->
        data = _.clone @data
        data['currency'] = 'EUR'
        data.transaction_types = [
          {
            init_recurring_sale3d: {
              bin: "123456",
              managed_recurring: {
                mode: "manual"
                max_amount: 1.11
              }
            }
          }
        ]

        @transaction.setData(data)
        trx = @transaction.getTrxData()

        assert.equal(
          trx.wpf_payment.transaction_types.transaction_type[0].managed_recurring.max_amount, 111
        )

  context 'idempotent, non-mutating builds', ->

    it 'produces identical top-level amount across repeated getTrxData builds', ->
      data            = _.clone @data
      data['currency'] = 'EUR'
      data['amount']   = '1.23'

      @transaction.setData(data)
      firstTrx  = @transaction.getTrxData()
      secondTrx = @transaction.getTrxData()

      assert.equal firstTrx.wpf_payment.amount, '123'
      assert.equal secondTrx.wpf_payment.amount, '123'

    it 'produces identical getArguments across repeated builds', ->
      data            = _.clone @data
      data['currency'] = 'EUR'
      data['amount']   = '1.23'

      @transaction.setData(data)
      firstArguments  = @transaction.getArguments()
      secondArguments = @transaction.getArguments()

      assert.equal firstArguments.trx.wpf_payment.amount, secondArguments.trx.wpf_payment.amount

    it 'produces identical XML across repeated builds', ->
      data            = _.clone @data
      data['currency'] = 'EUR'
      data['amount']   = '1.23'

      @transaction.setData(data)
      firstArguments  = @transaction.getArguments()
      secondArguments = @transaction.getArguments()
      firstXml        = @transaction.getRequestBody(firstArguments.trx)
      secondXml       = @transaction.getRequestBody(secondArguments.trx)

      assert.equal firstXml, secondXml
      assert.include firstXml, '<amount>123</amount>'
      assert.notInclude firstXml, '<amount>12300</amount>'

    it 'reshapes multiple transaction types stably across repeated builds', ->
      data            = _.clone @data
      data['currency'] = 'EUR'
      data['amount']   = '1.23'
      data.transaction_types = [
        'sale',
        'authorize'
      ]

      @transaction.setData(data)
      firstTrx  = @transaction.getTrxData()
      secondTrx = @transaction.getTrxData()

      firstTypes  = firstTrx.wpf_payment.transaction_types.transaction_type
      secondTypes = secondTrx.wpf_payment.transaction_types.transaction_type

      assert.equal firstTypes.length, 2
      assert.equal firstTypes[0]['@'].name, 'sale'
      assert.equal firstTypes[1]['@'].name, 'authorize'
      assert.deepEqual firstTypes, secondTypes

    it 'converts managed_recurring amount and max_amount exactly once', ->
      data            = _.clone @data
      data['currency'] = 'EUR'
      data.transaction_types = [
        {
          authorize: {
            bin: '123456',
            managed_recurring: {
              mode: 'manual'
              amount: 1.23
              max_amount: 4.56
            }
          }
        }
      ]

      @transaction.setData(data)
      firstTrx  = @transaction.getTrxData()
      secondTrx = @transaction.getTrxData()

      for trx in [firstTrx, secondTrx]
        managedRecurring = trx.wpf_payment.transaction_types.transaction_type[0].managed_recurring
        assert.equal managedRecurring.amount, '123'
        assert.equal managedRecurring.max_amount, '456'

    it 'preview body equals send body', ->
      data            = _.clone @data
      data['currency'] = 'EUR'
      data['amount']   = '1.23'

      @transaction.setData(data)
      previewArguments = @transaction.getArguments()
      previewBody      = @transaction.getRequestBody(previewArguments.trx)
      sendArguments    = @transaction.getArguments()
      sendBody         = @transaction.getRequestBody(sendArguments.trx)

      assert.equal previewBody, sendBody

    it 'does not mutate caller params across repeated builds', ->
      data            = _.clone @data
      data['currency'] = 'EUR'
      data['amount']   = '1.23'
      data.transaction_types = [
        {
          authorize: {
            bin: '123456',
            managed_recurring: {
              mode: 'manual'
              amount: 1.23
            }
          }
        }
      ]

      @transaction.setData(data)
      @transaction.getTrxData()
      @transaction.getTrxData()

      assert.equal data.amount, '1.23'
      assert.equal data.transaction_types[0].authorize.managed_recurring.amount, 1.23

  context 'with i18n', ->

    context 'with invalid request', ->

      it 'fails when wrong locale', ->
        data        = _.clone @data
        data.locale = 'NOT_VALID_LOCALE'

        assert.equal false, @transaction.setData(data).isValid()

  context 'with Tokenization attributes', ->

    context 'with invalid parameters', ->
      it 'raise validation error with invalid remember_card', ->
        data               = _.clone @data
        data.remember_card = 'true'

        assert.equal false, @transaction.setData(data).isValid()

      it 'raise validation error with invalid consumer_id', ->
        data             = _.clone @data
        data.consumer_id = faker.datatype.number({min: 11})

        assert.equal false, @transaction.setData(data).isValid()

    context 'with invalid request', ->

      it 'raise validation error with missing customer_email and present consumer_id', ->
        data             = _.clone @data
        data.consumer_id = faker.datatype.number({max: 10}).toString()
        delete data.customer_email

        assert.equal false, @transaction.setData(data).isValid()

    context 'with valid request', ->

      it 'should create consumer', ->
        data               = _.clone @data
        data.remember_card = true

        assert.equal true, @transaction.setData(data).isValid()

      it 'should send token data', ->
        data             = _.clone @data
        data.consumer_id = faker.datatype.number({max: 36}).toString()

        assert.equal true, @transaction.setData(data).isValid()

    context 'when lifetime', ->

      it 'with valid value', ->
        data        = _.extend @data
        transaction = _.extend @transaction

        data['lifetime'] = 20

        assert.equal true, transaction.setData(data).isValid()

      it 'with invalid value', ->
        data        = _.extend @data
        transaction = _.extend @transaction

        data['lifetime'] = 0

        assert.equal false, transaction.setData(data).isValid()

  context 'with scheme_tokenized', ->

    it 'works with scheme_tokenized set to true', ->
      data                   = _.clone @data
      data.scheme_tokenized  = true

      assert.equal true, @transaction.setData(data).isValid()

    it 'works with scheme_tokenized set to false', ->
      data                   = _.clone @data
      data.scheme_tokenized  = false

      assert.equal true, @transaction.setData(data).isValid()

    it 'fails with invalid scheme_tokenized value', ->
      data                   = _.clone @data
      data.scheme_tokenized  = 'true'

      assert.equal false, @transaction.setData(data).isValid()

  context 'with account_owner attribute', ->

    it 'works with top-level account_owner', ->
      data = _.clone @data
      data.account_owner = {
        first_name:  faker.random.alpha(35),
        middle_name: faker.random.alpha(35),
        last_name:   faker.random.alpha(35)
      }

      assert.equal true, @transaction.setData(data).isValid()

    it 'works with top-level account_owner using documented values', ->
      data = _.clone @data
      data.account_owner = {
        first_name:  'Travis',
        middle_name: 'Joe',
        last_name:   'Pastrana'
      }

      assert.equal true, @transaction.setData(data).isValid()

    it 'fails when account_owner first_name exceeds 35 characters', ->
      data = _.clone @data
      data.account_owner = {
        first_name:  faker.random.alpha(36),
        middle_name: 'Joe',
        last_name:   'Pastrana'
      }

      assert.equal false, @transaction.setData(data).isValid()

    it 'fails when account_owner is nested inside a transaction_type', ->
      data = _.clone @data
      data.transaction_types = [
        {
          sale: {
            account_owner: {
              first_name: 'John'
            }
          }
        }
      ]

      assert.equal false, @transaction.setData(data).isValid()

  context 'with billing_address.street_name', ->

    it 'works when street_name is set', ->
      data                 = _.clone @data
      data.billing_address =
        first_name:  faker.name.firstName()
        last_name:   faker.name.lastName()
        country:     faker.address.countryCode()
        street_name: faker.random.alpha(10)

      assert.equal true, @transaction.setData(data).isValid()

    it 'works when street_name is omitted', ->
      data = _.clone @data

      assert.equal true, @transaction.setData(data).isValid()

    it 'serializes street_name as a child of billing_address', ->
      street_name          = faker.random.alpha(10)
      data                 = _.clone @data
      data.billing_address =
        first_name:  faker.name.firstName()
        last_name:   faker.name.lastName()
        country:     faker.address.countryCode()
        street_name: street_name

      @transaction.setData(data)
      trx = @transaction.getTrxData()

      assert.equal trx.wpf_payment.billing_address.street_name, street_name


  BusinessAttributes()
  DigitalAssetTypes()
  DynamicDescriptor()
  DynamicDescriptorMerchantName()
  FinancialBase()
  PayLater()
  FundingAttributes()
