faker = require 'faker'
_     = require 'underscore'

RecurringType = () ->

  context 'with Recurring Type - initial and managed', ->

    context 'with invalid request', ->

      it 'fails when wrong recurring type was provided', ->
        data = _.clone @data
        data.recurring_type = 'not_exists'
        assert.equal false, @transaction.setData(data).isValid()

    context 'with valid request', ->

      it 'works when initial recurring type was provided', ->
        data = _.clone @data
        data.recurring_type = 'initial'
        assert.equal true, @transaction.setData(data).isValid()

      it 'works when managed recurring type was provided', ->
        data = _.clone @data
        data.recurring_type = 'managed'
        assert.equal true, @transaction.setData(data).isValid()

module.exports = RecurringType
