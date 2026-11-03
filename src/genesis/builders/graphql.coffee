_               = require 'underscore'
GraphqlRawValue = require '../utils/graphql_raw_value'

###
  GraphQL Query Builder
  Converts structured JavaScript objects into valid GraphQL query strings
  for the application/graphql content type.
###
class Graphql

  # Pattern for valid GraphQL names
  NAME_PATTERN: /^[A-Za-z_][A-Za-z0-9_]*$/

  ###
    Create a raw/enum GraphQL value that will not be quoted
    @param {String} value - The raw value (must match identifier pattern)
    @return {GraphqlRawValue}
  ###
  @raw: (value) ->
    new GraphqlRawValue(value)

  ###
    Create a GraphQL enum value that will not be quoted
    Same as raw(), but additionally rejects true, false and null (not valid EnumValues)
    @param {String} value - The enum value (must match identifier pattern)
    @return {GraphqlRawValue}
  ###
  @enum: (value) ->
    new GraphqlRawValue(value, true)

  ###
    Convert structured object to GraphQL query string
    @param {Object} structure - Query structure with query name, arguments, fields
    @return {String} Formatted GraphQL query string, or '' for empty input
  ###
  buildStructure: (structure) ->
    return '' if _.isEmpty(structure)

    keys = _.keys(structure)
    if keys.length != 1
      throw new Error('GraphQL builder supports exactly one root query')

    queryName = keys[0]
    @validateName(queryName)
    queryData = structure[queryName]

    unless @isPlainObject(queryData)
      throw new Error('GraphQL root query data must be an object')

    args = {}
    fields = null

    for own key, value of queryData
      if key == 'fields'
        fields = value
      else
        args[key] = value

    argsStr = @buildArguments(args)
    fieldsStr = @buildFields(fields, '    ')

    lines = []
    lines.push 'query {'
    lines.push if argsStr then "  #{queryName}(#{argsStr}) {" else "  #{queryName} {"
    lines.push fieldsStr
    lines.push '  }'
    lines.push '}'

    lines.join('\n') + '\n'

  ###
    Serialize all argument key-value pairs (generic, not hardcoded to filter/sort/paging)
    Arguments with null/undefined values are omitted
    @param {Object} args - Arguments object (keys other than 'fields')
    @return {String} Serialized arguments string, or '' when no arguments remain
  ###
  buildArguments: (args) ->
    pairs = []
    for own key, value of args
      @validateName(key)
      continue unless value?
      pairs.push "#{key}: #{@formatValue(value)}"

    pairs.join(' ')

  ###
    Recursive type-aware value serialization
    Handles: strings, numbers, booleans, arrays, plain (nested) objects, raw/enum values
    Null/undefined entries of input objects are omitted; callers must filter them out
    before passing a value directly.
    @param {*} value - The value to serialize
    @throws {Error} For null/undefined, Date, non-plain objects and unsupported types
    @return {String} Serialized GraphQL value
  ###
  formatValue: (value) ->
    unless value?
      throw new Error("Invalid GraphQL value: #{value}")

    if GraphqlRawValue.isRaw(value)
      return value.toGraphql()

    if typeof value == 'string'
      return JSON.stringify(value)

    if typeof value == 'boolean'
      return if value then 'true' else 'false'

    if typeof value == 'number'
      unless isFinite(value)
        throw new Error("Invalid GraphQL number: #{value}")
      return "#{value}"

    if _.isArray(value)
      items = value.map (item) =>
        throw new Error("Invalid GraphQL list item: #{item}") unless item?
        @formatValue(item)
      return "[#{items.join(', ')}]"

    if _.isDate(value)
      throw new Error(
        'Invalid GraphQL value: Date objects are not supported, format dates as strings'
      )

    if @isPlainObject(value)
      pairs = []
      for own key, nestedValue of value
        @validateName(key)
        continue unless nestedValue?
        pairs.push "#{key}: #{@formatValue(nestedValue)}"
      return if pairs.length then "{ #{pairs.join(', ')} }" else '{}'

    type = if _.isObject(value) and not _.isFunction(value) then 'object' else typeof value
    throw new Error("Unsupported GraphQL value type: #{type}")

  ###
    Check whether the value is a plain object (object literal or Object.create(null))
    @param {*} value
    @return {Boolean}
  ###
  isPlainObject: (value) ->
    return false unless value? and typeof value == 'object'

    prototype = Object.getPrototypeOf(value)
    prototype == Object.prototype or prototype == null

  ###
    Validate a GraphQL structural name against the GraphQL Name grammar
    @param {String} value - The name to validate
    @throws {Error} If the value does not match the allowed pattern
  ###
  validateName: (value) ->
    unless typeof value == 'string' and @NAME_PATTERN.test(value)
      throw new Error("Invalid GraphQL name: #{value}")

  ###
    Recursively serialize field selections including nested blocks
    @param {Array} fields - Non-empty array of field names and/or nested block objects
    @param {String} indent - Current indentation string
    @return {String} Serialized field selection string
  ###
  buildFields: (fields, indent = '    ') ->
    unless _.isArray(fields) and fields.length > 0
      throw new Error('GraphQL field selection must be a non-empty array')

    lines = []
    for field in fields
      if typeof field == 'string'
        @validateName(field)
        lines.push "#{indent}#{field}"
      else if _.isObject(field) and not _.isArray(field) and field != null
        blockNames = _.keys(field)
        unless blockNames.length == 1
          throw new Error('Invalid GraphQL field selection')

        blockName = blockNames[0]
        @validateName(blockName)
        lines.push "#{indent}#{blockName} {"
        lines.push @buildFields(field[blockName], "#{indent}  ")
        lines.push "#{indent}}"
      else
        throw new Error('Invalid GraphQL field selection')

    lines.join('\n')

module.exports = Graphql
