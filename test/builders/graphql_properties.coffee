# Feature: graphql-builder - Property-Based Tests
# Complements the example-based tests in test/builders/graphql.coffee with randomized input.

fc      = require 'fast-check'
Graphql = require '../../src/genesis/builders/graphql'

describe 'GraphQL Builder Property Tests', ->

  NUM_RUNS = 25

  builder = new Graphql()

  lowercase  = 'abcdefghijklmnopqrstuvwxyz'.split('')
  identChars = lowercase.concat('ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789_'.split(''))

  # Valid GraphQL name: lowercase letter followed by identifier characters
  nameArb = fc.tuple(
    fc.constantFrom(lowercase...)
    fc.stringOf(fc.constantFrom(identChars...), { maxLength: 10 })
  ).map(([first, rest]) -> first + rest)

  build = (filter, fields = ['id']) ->
    builder.buildStructure({ q: { filter: filter, fields: fields } })

  it 'preserves every argument key, string value and field name', ->
    fc.assert(
      fc.property(
        fc.dictionary(nameArb, fc.string(), { minKeys: 1, maxKeys: 3 })
        fc.array(nameArb, { minLength: 1, maxLength: 5 })
        (args, fields) ->
          output = build(args, fields)
          for key, value of args
            expect(output).to.include("#{key}: #{JSON.stringify(value)}")
          for field in fields
            expect(output).to.include("\n    #{field}\n")
          return
      )
      { numRuns: NUM_RUNS }
    )

  it 'formats integers and booleans unquoted', ->
    fc.assert(
      fc.property fc.integer(), fc.boolean(), (int, bool) ->
        expect(build({ int: int, bool: bool })).to.include("{ int: #{int}, bool: #{bool} }")
        return
      { numRuns: NUM_RUNS }
    )

  it 'outputs valid raw/enum values unquoted', ->
    fc.assert(
      fc.property nameArb, (value) ->
        expect(build({ direction: Graphql.raw(value) })).to.include("{ direction: #{value} }")
        return
      { numRuns: NUM_RUNS }
    )
