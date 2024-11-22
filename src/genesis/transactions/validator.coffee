###
Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NON-INFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.

@license http://opensource.org/licenses/MIT The MIT License
###

ajv = require 'ajv'
_   = require 'underscore'

# Request Validator module
class Validator

  constructor: (@trx) ->
    @baseUrl = 'https://genesis.js/'
    @validationErrors = []
    @isConfigSchema = false

    @ajv = new ajv allErrors: true

    # load definitions schema
    @ajv.addSchema(require '../../../schemas/definitions/definitions.json' )
    @ajv.addSchema(require '../../../schemas/definitions/country.json')
    @ajv.addSchema(require '../../../schemas/definitions/currency.json')
    @ajv.addSchema(require '../../../schemas/definitions/i18n.json')

    # Attributes
    @ajv.addSchema(require '../../../schemas/definitions/attributes/business_attributes.json' )
    @ajv.addSchema(require '../../../schemas/definitions/attributes/sca_params.json')
    @ajv.addSchema(require '../../../schemas/definitions/attributes/threeds/v1/threeds_v1.json')
    @ajv.addSchema(require '../../../schemas/definitions/attributes/threeds/v2/threeds_v2.json')
    @ajv.addSchema(require '../../../schemas/definitions/attributes/wpf/transaction_types.json')
    @ajv.addSchema(require '../../../schemas/definitions/attributes/financial/common.json')
    @ajv.addSchema(require '../../../schemas/definitions/attributes/financial/payment.json')
    @ajv.addSchema(require '../../../schemas/definitions/attributes/financial/tokenization.json')
    @ajv.addSchema(require '../../../schemas/definitions/attributes/customer/address.json')
    @ajv.addSchema(
      require '../../../schemas/definitions/attributes/recurring/managed_recurring.json'
    )
    @ajv.addSchema(require '../../../schemas/definitions/attributes/risk_attributes.json')
    @ajv.addSchema(
      require '../../../schemas/definitions/attributes/financial/dynamic_descriptor_params.json'
    )
    @ajv.addSchema(
      require '../../../schemas/definitions/attributes/financial/travel_data/travel_data_attributes.json'
    )
    @ajv.addSchema(require '../../../schemas/definitions/attributes/cof_attributes.json')
    @ajv.addSchema(
      require '../../../schemas/definitions/attributes/financial/funding_attributes.json'
    )
    @ajv.addSchema(
      require '../../../schemas/definitions/attributes/financial/account_owner_attributes.json'
    )

  # Compare the specific transaction schema against the request parameters

  isValid: () ->
    try
      @schema = require '../../../schemas/' + @trx.getTransactionType() + '.json'
    catch error
      @addError
        message:
          'JSON schema not found for this request'
      return false

    @ajv.validate @schema, @trx.getData()

  isValidConfig: () ->
    @isConfigSchema = true
    try
      @schema = require '../../../schemas/config/config.json'
    catch error
      @addError
        message:
          'JSON schema not found for this request'
      return false

    @ajv.validate @schema, @trx.configuration.getConfig()

  # Get all ajv errors
  # Possible with ajv allErrors: true option
  getErrors: () ->
    if @ajv.errors
      for error in @ajv.errors
        @setError error

    @validationErrors

  # Check for predefined error messages by error.keyword
  setError: (error) ->
    # add error messages for invalid properties value
    if _.indexOf([
      'required',
      'additionalProperties'
      'const',
      'enum',
      'maxLength',
      'minLength',
      'type',
      'pattern',
      'format',
      'minimum',
      'maximum',
      'dependencies',
      'anyOf',
      'oneOf'
    ], error.keyword) != -1
      message = @getPreDefinedErrorMessage error

    if message
      @addError
        "type":
          error.keyword
        "property":
          @getPropertyName error
        "message":
          message

  addError: (error) ->
    @validationErrors.push error

  # Extract the affected property
  getPropertyName: (error) ->
    parts = []
    if error.dataPath
      parts = error.dataPath.split '.'

    switch error.keyword
      when 'additionalProperties' then parts.push error.params.additionalProperty
      when 'required' then parts.push error.params.missingProperty
      when 'dependencies' then parts.push error.params.property

    _.compact(parts).join('.')

  # Get user friendly error for error.keyword 'additionalProperties'
  getAdditionalErrorMessage: (error) ->
    "Not allowed field #{@getPropertyName error}"

  # Get user friendly error for error.keyword required
  getRequiredErrorMessage: (error) ->
    "Field #{@getPropertyName error} is required#{@getRequiredErrorMessageSuffix error}"

  # Build the specific error suffix based on the error.keyword and the given schema logic
  # TODO consider removing it, AJV doesn't return schemaPath for if then
  getRequiredErrorMessageSuffix: (error) ->
    suffix    = ''
    refSchema = @getRefErrorSchema(error)
    schema    = @ajv.getSchema("#{@baseUrl}#{@trx.getTransactionType()}")

    ref = if refSchema then refSchema.split('#')
    ref = if ref[1] then ref[1].split('/') else ref

    if ref[1] == 'then' && schema.refVal[schema.refs[refSchema]]
      for property, value of schema.refVal[schema.refs[refSchema]]['if'].properties
        suffix += if suffix then ' and ' else ' when '
        suffix += "#{property} is "
        if value.enum
          suffix += value.enum.join " or "
        else if value.const
          suffix += value.const
        else
          suffix += 'present'

    suffix

  # Get predefined error message
  # If error.keyword is not set then the default ajv error message will be displayed
  getPreDefinedErrorMessage: (error) ->
    suffix =
      @getMessage(error) ||
      switch error.keyword
        when 'required'             then @getRequiredErrorMessage(error)
        when 'additionalProperties' then @getAdditionalErrorMessage(error)
        when 'const'                then "Allowed value is #{error.params.allowedValue}"
        when 'enum'                 then "Allowed values are #{error.params.allowedValues.join ', '}"
        when 'maxLength'            then "Should be string shorter or equal #{error.params.limit}"
        when 'minLength'            then "Should be string longer or equal #{error.params.limit}"
        when 'type'                 then "Should be #{error.params.type}"
        when 'pattern'              then "Should match pattern #{error.params.pattern}"
        when 'format'               then "Should be valid #{error.params.format}"
        when 'dependencies'         then "Request #{error.message}"
        when 'anyOf'                then "Check API Documentation."
        else ''
    if suffix
      suffix = ". #{suffix}"
    "#{@getMessagePrefix(error)}#{suffix}"

  switchSchema: () ->
    if @isConfigSchema == true
      @ajv.getSchema("#{@baseUrl}config")
    else
      @ajv.getSchema("#{@baseUrl}#{@trx.getTransactionType()}")

  getMessage: (error) ->
    ref    = @getRefErrorSchema(error)
    schema = @switchSchema()

    # The schema property predefined message has first priority
    message = @getPropertyMessage(ref, schema, error.keyword)
    if (not _.isEmpty(message))
      return message

    # The pre-defined schema message has second priority
    message = @getCustomMessage(schema.schema, error.keyword)
    if (not _.isEmpty(message))
      return message

    # The external schemas property messages are last
    message = @getMessageFromRef(ref, error.keyword)
    if (not _.isEmpty(message))
      return message

  # User friendly message prefix
  getMessagePrefix: (error) ->
    switch error.keyword
      when 'anyOf', 'oneOf' then "Request depends on specific rules"
      when 'additionalProperties' then "Request contain invalid field"
      else "Field #{@getPropertyName error} has invalid value"

  # Extract the pre-defined message from a property
  getPropertyMessage: (ref, schema, keyword) ->
    if schema.refVal[schema.refs[ref]]
      property = schema.refVal[schema.refs[ref]]

      propertyName = ref.split('#')
      if property.properties && property.properties[propertyName[1]]
        property = property.properties[propertyName[1]]

      @getCustomMessage(property, keyword)

  # Extract the pre-defined message from a schema
  getMessageFromRef: (ref, keyword) ->
    refSchema = @ajv.getSchema(ref)

    if not refSchema
      return ''

    @getCustomMessage(refSchema.schema, keyword)

  # Get the pre-defined message
  getCustomMessage: (object, keyword) ->
    if object.message
      return object.message

    if object.messages
      if _.isArray(object.messages[keyword])
        return object.messages[keyword].join(' ')

      return object.messages[keyword]

  # Get the schema that raise error
  getRefErrorSchema: (error) ->
    refPath = error.schemaPath.split('#')
    if _.isEmpty(refPath[0])
      refPath[0] = @trx.getTransactionType()

    ref = if refPath[0].startsWith('/') then refPath[0].substring(1) else refPath[0]
    if refPath[1]
      url = refPath[1].replace("/properties/", "").split('/')
      url = if (url.includes('then') || url.includes('if')) then url.join('/') else url[0]
      ref = "#{@baseUrl}#{ref}##{url}"

    return ref

module.exports = Validator
