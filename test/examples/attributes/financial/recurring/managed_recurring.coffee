faker = require 'faker'
_     = require 'underscore'

ManagedRecurring = () ->

  context 'with managed recurring', ->

    context 'with invalid request', ->

      it 'fails when managed recurring mode property was set with wrong value', ->
        data = _.clone @data
        data.managed_recurring.mode = 'not_exists_mode'
        assert.equal false, @transaction.setData(data).isValid()

      it 'fails when missing required mode parameter', ->
        data = _.clone @data
        delete data.managed_recurring.mode
        assert.equal false, @transaction.setData(data).isValid()

      it 'fails when wrong value of payment_type was provided', ->
        data = _.clone @data
        data.managed_recurring.payment_type = 'not_exists'
        assert.equal false, @transaction.setData(data).isValid()

      it 'fails when wrong value of amount_type was provided', ->
        data = _.clone @data
        data.managed_recurring.amount_type = 'not_exists'
        assert.equal false, @transaction.setData(data).isValid()

      it 'fails when wrong value of frequency was provided', ->
        data = _.clone @data
        data.managed_recurring.frequency = 'not_exists'
        assert.equal false, @transaction.setData(data).isValid()

      it 'fails when registration_reference_number length was greater than 35', ->
        data = _.clone @data
        data.managed_recurring.registration_reference_number = "123456789012345678901234567890123456"

        assert.equal false, @transaction.setData(data).isValid()

      it 'fails when string of max_count was provided', ->
        data = _.clone @data
        data.managed_recurring.max_count = faker.datatype.number().toString()
        assert.equal false, @transaction.setData(data).isValid()

      it 'fails when string of validated was provided', ->
        data = _.clone @data
        data.managed_recurring.validated = 'true'
        assert.equal false, @transaction.setData(data).isValid()

      it 'fails when wrong value of interval was provided', ->
        data = _.clone @data
        data.managed_recurring.interval = 'not_exists'
        assert.equal false, @transaction.setData(data).isValid()

      it 'fails when string of time_of_day was provided', ->
        data = _.clone @data
        data.managed_recurring.time_of_day = faker.datatype.number().toString()
        assert.equal false, @transaction.setData(data).isValid()

      it 'fails when string of period was provided', ->
        data = _.clone @data
        data.managed_recurring.period = faker.datatype.number().toString()
        assert.equal false, @transaction.setData(data).isValid()

      it 'fails when wrong date format was provided', ->
        data = _.clone @data
        data.managed_recurring.first_date = '12.10.2020'
        assert.equal false, @transaction.setData(data).isValid()

      it 'fails when wrong managed_recurring amount parameter', ->
        data = _.clone @data
        data.managed_recurring.amount = -1000
        assert.equal false, @transaction.setData(data).isValid()

    context 'with valid request', ->

      it 'works with valid managed_recurring', ->
        data = _.clone @data

        data.managed_recurring.mode = 'manual'
        data.managed_recurring.payment_type = 'subsequent'
        data.managed_recurring.amount_type = 'fixed'
        data.managed_recurring.frequency = 'weekly'
        data.managed_recurring.registration_reference_number = '123456'
        data.managed_recurring.max_amount = 200
        data.managed_recurring.max_count = 99
        data.managed_recurring.validated = true
        data.managed_recurring.interval = 'days'
        data.managed_recurring.first_date = '2020-02-13'
        data.managed_recurring.time_of_day = 5
        data.managed_recurring.period = 1
        data.managed_recurring.amount = 12

        assert.equal true, @transaction.setData(data).isValid()

      it 'works with integer amount parameter', ->
        data = _.clone @data
        data['managed_recurring']['amount'] = 100
        assert.equal true, @transaction.setData(data).isValid()

      it 'works with number amount parameter', ->
        data = _.clone @data
        data['managed_recurring']['amount'] = 1.11
        assert.equal true, @transaction.setData(data).isValid()

      it 'works with string amount parameter', ->
        data = _.clone @data
        data['managed_recurring']['amount'] = "1.11"
        assert.equal true, @transaction.setData(data).isValid()

      it 'works when amount of managed_recurring attribute was provided', ->
        data = _.clone @data
        data['managed_recurring']['amount'] = 1.11
        data['currency'] = 'EUR'

        @transaction.setData(data)
        trx = @transaction.getTrxData()

        assert.equal(
          trx.payment_transaction.managed_recurring.amount, 111
        )

      it 'works when managed_recurring attribute was not provided', ->
        data = _.clone @data
        delete data.managed_recurring

        @transaction.setData(data)
        trx = @transaction.getTrxData()

        assert.equal(
          trx.payment_transaction.managed_recurring, undefined
        )

      it 'works when string of amount was provided', ->
        data = _.clone @data
        data.managed_recurring.amount = faker.datatype.number().toString()

        assert.isTrue @transaction.setData(data).isValid()

      it 'fails when string of max_amount was provided', ->
        data = _.clone @data
        data.managed_recurring.max_amount = faker.datatype.number().toString()

        assert.isTrue @transaction.setData(data).isValid()

module.exports = ManagedRecurring
