###
  Wrapper for raw/enum GraphQL values that should not be quoted
###
class GraphqlRawValue

  # Pattern for valid GraphQL raw/enum values
  PATTERN: /^[A-Za-z_][A-Za-z0-9_]*$/

  # Literals that match PATTERN but are not valid GraphQL EnumValues
  ENUM_RESERVED: ['true', 'false', 'null']

  ###
    @param {String} value - The raw/enum value
    @param {Boolean} isEnum - When true, the value must also be a valid GraphQL EnumValue
  ###
  constructor: (@value, @isEnum = false) ->

  ###
    Check whether the given value is a GraphqlRawValue instance
    @param {*} value
    @return {Boolean}
  ###
  @isRaw: (value) ->
    value instanceof GraphqlRawValue

  ###
    Validate the wrapped value against the allowed pattern
    @throws {Error} If the value does not match the allowed pattern,
      or if an enum value is true, false or null
    @return {String} The validated raw value
  ###
  toGraphql: ->
    unless typeof @value == 'string' and @PATTERN.test(@value)
      throw new Error("Invalid GraphQL raw value: #{@value}")

    if @isEnum and @value in @ENUM_RESERVED
      throw new Error("Invalid GraphQL enum value: #{@value}")

    @value

module.exports = GraphqlRawValue
