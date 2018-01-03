
Request   = require '../request'
Currency  = require '../helpers/currency'
_         = require 'underscore'
Validator = require '../helpers/validators/validator'

class Base

  constructor: (@params) ->
    @request  = new Request
    @currency = new Currency

    ###
    Define transaction required fields
    E.g. ['amount', 'country']
    ###
    @requiredFields = []

    ###
    Define transaction required fields OR. At least one of listed fields should be filled
    E.g. ['amount', 'country']
    ###
    @requiredFieldsOr = []

    ###
    Define transaction conditionally required fields
    E.g. 'currency':
            'USD': [
              'bank_account'
            ]
    E.g. 'notification_url': ['return_success_url', 'return_failure_url']
    ###
    @requiredFieldsConditional = {}

    ###
    Define transaction fields allowed values
    E.g. 'currency': ['EUR', 'USD']
    ###
    @fieldsValues = {}

    ###
    Define transaction fields conditionally allowed values
    E.g. 'currency':
            'USD': {
              'card_number': new RegExp '^[0-9]{20}$'
            }
    E.g. 'state':
            'country': ['US', 'CA']
    ###
    @fieldsValuesConditional = {}

    ###
    Define transaction groups of required fields. At least one group should be filled
    E.g. 'asynchronous':
           ['notification_url', 'return_success_url', 'return_failure_url']
         'synchronous':
           ['mpi_eci']
    ###
    @requiredFieldsGroups = {}

  ###
    Get field value using dot notation
  ###
  getValue: (field) ->
    field.split('.').reduce(
      (a, b) ->
        if !_.isUndefined(a)
          a[b]
        else
          undefined
      ,
      @params
    )

  validateRequiredFields: (fields = @requiredFields, message_suffix = "") ->
    for field in fields
      fieldValue = @getValue field
      if !fieldValue || (_.isObject(fieldValue) && _.isEmpty(fieldValue))
        @validationErrors.push "Field #{field} is required" + message_suffix

  validateRequiredFieldsOr: (fields = @requiredFieldsOr) ->
    if fields.length
      show_error = true
      for field in fields
        if @getValue field
          show_error = false
          break

      if show_error
        @validationErrors.push "At least one of #{fields.join(', ')} fields has to be filled"

  validateRequiredFieldsConditional: ->
    for field, conditions of @requiredFieldsConditional

      fieldValue = @getValue field
      if !_.isUndefined(fieldValue) and !_.isEmpty(fieldValue)

        # if fields are required when given field exists
        if _.isArray(conditions)
          this.validateRequiredFields(conditions, " when #{field} is not empty")

        # if fields are required when given field has exact value
        else if _.isObject(conditions) and !_.isUndefined(conditions[fieldValue])
          this.validateRequiredFields(conditions[fieldValue], " when #{field} is #{fieldValue}")

  validateFieldsValues: (fields = @fieldsValues, message_suffix = "") ->
    for field, value of fields

      fieldValue = @getValue field
      if !_.isUndefined(fieldValue)

        # check if field value exists in the given array
        if _.isArray(value) and _.indexOf(value, fieldValue) == -1
          @validationErrors.push "Field #{field} has invalid value. Allowed values are: #{value.join(', ')}" + message_suffix

        # check if field value match the given regular expression
        else if _.isRegExp(value) and !value.test(fieldValue)
          @validationErrors.push "Field #{field} has invalid value. Allowed format is #{value}" + message_suffix

        # check if field value pass given validator
        else if value instanceof Validator and !value.isValid fieldValue
          @validationErrors.push value.getMessage(field) + message_suffix

        # check if field value match exact given value
        else if (typeof value == 'string' or _.isNumber(value)) and fieldValue != value
          @validationErrors.push "Field #{field} has invalid value. Allowed value is #{value}" + message_suffix

  validateFieldsValuesConditional: ->
    for field, conditions of @fieldsValuesConditional

      fieldValue = @getValue field
      if !_.isUndefined(fieldValue) and !_.isEmpty(fieldValue)

        # check fields values if given field exists
        if _.isUndefined(conditions[fieldValue])
          this.validateFieldsValues(conditions, " when #{field} is not empty")

        # check fields values if given field has exact value
        else
          this.validateFieldsValues(conditions[fieldValue], " when #{field} is #{fieldValue}")

  validateRequiredFieldsGroups: ->
    if !_.isEmpty @requiredFieldsGroups
      groupsFormatted = []
      hasOneFilledGroup = false

      for group, fields of @requiredFieldsGroups

        groupsFormatted.push "#{group}(#{fields.join ', '})"

        emptyFieldInGroup = false

        for field in fields
          fieldValue = @getValue field
          if !fieldValue || (_.isObject(fieldValue) && _.isEmpty(fieldValue))
            emptyFieldInGroup = true

        if !emptyFieldInGroup
          hasOneFilledGroup = true

      if !hasOneFilledGroup
        @validationErrors.push "One of the following group/s of field/s must be filled in: #{groupsFormatted.join '; '}"

  isValid: ->
    @validationErrors = []

    this.validateRequiredFields()
    this.validateRequiredFieldsOr()
    this.validateRequiredFieldsConditional()
    this.validateFieldsValues()
    this.validateFieldsValuesConditional()
    this.validateRequiredFieldsGroups()

    @validationErrors.length == 0

  send: (onSuccess, onFailure) ->
    if !this.isValid()
      return onFailure('validationErrors', @validationErrors)

    args =
      callbacks:
        success:
          onSuccess
        failure:
          onFailure
      trx:
        @getTrxData()
      url:
        @getUrl()

    @request.send args

module.exports = Base