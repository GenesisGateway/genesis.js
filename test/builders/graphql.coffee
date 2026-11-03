Graphql = require '../../src/genesis/builders/graphql'

describe 'GraphQL builder', ->
  beforeEach ->
    @builder = new Graphql()

  context 'when empty structure', ->
    it 'returns empty string', ->
      assert.equal @builder.buildStructure({}), ''

  context 'when multiple root keys', ->
    it 'throws an error', ->
      fn = => @builder.buildStructure({ query1: {}, query2: {} })
      expect(fn).to.throw('GraphQL builder supports exactly one root query')

  context 'when query name', ->
    it 'appears after query {', ->
      output = @builder.buildStructure({ myQuery: { fields: ['id'] } })
      assert.include output, 'query {\n  myQuery'

  context 'when filter arguments', ->
    it 'with string values quoted', ->
      output = @builder.buildStructure({ q: { filter: { name: "test" }, fields: ['id'] } })
      assert.include output, 'name: "test"'

    it 'with integer values unquoted', ->
      output = @builder.buildStructure({ q: { filter: { count: 42 }, fields: ['id'] } })
      assert.include output, 'count: 42'
      assert.notInclude output, 'count: "42"'

    it 'with boolean values as unquoted true/false', ->
      output = @builder.buildStructure({
        q: { filter: { a: true, b: false }, fields: ['id'] }
      })
      assert.include output, 'filter: { a: true, b: false }'

  context 'when sort and paging arguments', ->
    it 'in key: { } format', ->
      output = @builder.buildStructure({
        q: { sort: { name: "ASC" }, paging: { page: 1 }, fields: ['id'] }
      })
      assert.include output, 'sort: { name: "ASC" }'
      assert.include output, 'paging: { page: 1 }'

  context 'when multiple argument groups', ->
    it 'are space-separated', ->
      output = @builder.buildStructure({
        q: { filter: { a: 1 }, sort: { b: "DESC" }, fields: ['id'] }
      })
      assert.include output, '} sort: {'

  context 'when fields', ->
    it 'output on separate lines', ->
      output = @builder.buildStructure({ q: { fields: ['id', 'name', 'email'] } })
      lines = output.split('\n')
      fieldLines = lines.filter (l) -> l.trim() in ['id', 'name', 'email']
      assert.equal fieldLines.length, 3

  context 'when nested field blocks', ->
    it 'serializes multiple nesting levels with two-space indentation', ->
      output = @builder.buildStructure({
        q:
          fields: ['id', { items: ['uniqueId', { details: ['category', 'amount'] }] }]
      })
      expected = [
        'query {'
        '  q {'
        '    id'
        '    items {'
        '      uniqueId'
        '      details {'
        '        category'
        '        amount'
        '      }'
        '    }'
        '  }'
        '}'
        ''
      ].join('\n')
      assert.equal output, expected

  context 'when string escaping', ->
    it 'escapes double quotes in string values', ->
      output = @builder.buildStructure({
        q:
          filter: { merchantTransactionId: 'Order "123"' }
          fields: ['id']
      })
      assert.include output, 'merchantTransactionId: "Order \\"123\\"'

    it 'escapes backslashes in string values', ->
      output = @builder.buildStructure({
        q:
          filter: { path: 'C:\\Users\\test' }
          fields: ['id']
      })
      assert.include output, 'path: "C:\\\\Users\\\\test"'

    it 'escapes newlines in string values', ->
      output = @builder.buildStructure({
        q:
          filter: { note: "line1\nline2" }
          fields: ['id']
      })
      assert.include output, 'note: "line1\\nline2"'

  context 'when array values', ->
    it 'serializes string arrays as GraphQL lists', ->
      output = @builder.buildStructure({
        q:
          filter: { uniqueId: ['abc123', 'def456'] }
          fields: ['id']
      })
      assert.include output, 'uniqueId: ["abc123", "def456"]'

    it 'serializes integer arrays as GraphQL lists', ->
      output = @builder.buildStructure({
        q:
          filter: { ids: [1, 2, 3] }
          fields: ['id']
      })
      assert.include output, 'ids: [1, 2, 3]'

    it 'serializes mixed arrays', ->
      output = @builder.buildStructure({
        q:
          filter: { mixed: ['abc', 123, true] }
          fields: ['id']
      })
      assert.include output, 'mixed: ["abc", 123, true]'

  context 'when nested input objects', ->
    it 'serializes nested objects recursively', ->
      output = @builder.buildStructure({
        q:
          filter: { dateRange: { startDate: '2023-12-20', endDate: '2023-12-21' } }
          fields: ['id']
      })
      assert.include output, 'dateRange: { startDate: "2023-12-20", endDate: "2023-12-21" }'

  context 'when null values', ->
    it 'omits null/undefined entries', ->
      output = @builder.buildStructure({
        q:
          filter: { a: null, b: undefined, c: 1 }
          fields: ['id']
      })
      assert.include output, 'q(filter: { c: 1 }) {'

    it 'omits null/undefined arguments and the parentheses when none remain', ->
      output = @builder.buildStructure({
        q:
          filter: null
          sort: undefined
          fields: ['id']
      })
      assert.include output, 'query {\n  q {\n'
      assert.notInclude output, 'null'

    it 'serializes an emptied nested object as {}', ->
      output = @builder.buildStructure({
        q:
          filter: { range: { from: null } }
          fields: ['id']
      })
      assert.include output, 'filter: { range: {} }'

    it 'throws for null list items', ->
      fn = => @builder.buildStructure({ q: { filter: { ids: [1, null] }, fields: ['id'] } })
      expect(fn).to.throw('Invalid GraphQL list item: null')

    it 'throws when formatValue is given null directly', ->
      expect(=> @builder.formatValue(null)).to.throw('Invalid GraphQL value')

  context 'when non-plain values', ->
    it 'throws for Date objects', ->
      fn = => @builder.buildStructure({ q: { filter: { startDate: new Date() }, fields: ['id'] } })
      expect(fn).to.throw('Invalid GraphQL value: Date objects are not supported')

    it 'throws for invalid Date objects', ->
      fn = => @builder.buildStructure({ q: { filter: { d: new Date('x') }, fields: ['id'] } })
      expect(fn).to.throw('Date objects are not supported')

    it 'throws for class instances', ->
      class Filter
        constructor: -> @a = 1
      fn = => @builder.buildStructure({ q: { filter: { f: new Filter() }, fields: ['id'] } })
      expect(fn).to.throw('Unsupported GraphQL value type: object')

    it 'throws for functions', ->
      fn = => @builder.buildStructure({ q: { filter: { f: -> 1 }, fields: ['id'] } })
      expect(fn).to.throw('Unsupported GraphQL value type: function')

    it 'throws for a class instance as root query data', ->
      class Query
        constructor: -> @fields = ['id']
      fn = => @builder.buildStructure({ q: new Query() })
      expect(fn).to.throw('GraphQL root query data must be an object')

    it 'serializes Object.create(null) objects', ->
      filter = Object.create(null)
      filter.a = 1
      output = @builder.buildStructure({ q: { filter: filter, fields: ['id'] } })
      assert.include output, 'filter: { a: 1 }'

  context 'when Object.prototype is polluted', ->
    it 'does not emit inherited keys', ->
      try
        Object.prototype.polluted = 'x'
        output = @builder.buildStructure({
          q:
            filter: { a: 1, range: { from: '2023-12-20' } }
            fields: ['id']
        })
        assert.notInclude output, 'polluted'
        assert.include output, 'q(filter: { a: 1, range: { from: "2023-12-20" } }) {'
      finally
        delete Object.prototype.polluted

  context 'when raw/enum values', ->
    it 'outputs raw values unquoted', ->
      output = @builder.buildStructure({
        q:
          sort: { byDirection: Graphql.raw('desc') }
          fields: ['id']
      })
      assert.include output, 'byDirection: desc'
      assert.notInclude output, 'byDirection: "desc"'

    it 'throws on invalid raw values', ->
      fn = =>
        @builder.buildStructure({
          q:
            sort: { byDirection: Graphql.raw('desc) { hackedField }') }
            fields: ['id']
        })
      expect(fn).to.throw('Invalid GraphQL raw value')

    it 'allows valid identifier-like raw values', ->
      for val in ['asc', 'DESC', 'active_status', 'Type1']
        fn = =>
          @builder.buildStructure({
            q:
              sort: { field: Graphql.raw(val) }
              fields: ['id']
          })
        expect(fn).to.not.throw()

  context 'when real Billing Transactions query', ->
    it 'produces the expected full output', ->
      output = @builder.buildStructure({
        billingTransactions:
          filter:
            startDate: '2023-12-20 10:51:22'
            endDate: '2023-12-20 11:06:25'
            transactionType: 'Sale Approved'
          sort:
            byDirection: Graphql.raw('desc')
          paging:
            page: 1
            perPage: 100
          fields: [
            {
              items: [
                'billingStatement'
                'uniqueId'
                'transactionType'
                'billingAmount'
                'billingCurrency'
                'transactionDate'
                'merchantTransactionId'
                'paymentType'
              ]
            }
            {
              paging: [
                'page'
                'perPage'
                'pagesCount'
                'totalCount'
              ]
            }
          ]
      })

      expected = [
        'query {'
        '  billingTransactions(' +
          'filter: { startDate: "2023-12-20 10:51:22", endDate: "2023-12-20 11:06:25", ' +
          'transactionType: "Sale Approved" } ' +
          'sort: { byDirection: desc } paging: { page: 1, perPage: 100 }) {'
        '    items {'
        '      billingStatement'
        '      uniqueId'
        '      transactionType'
        '      billingAmount'
        '      billingCurrency'
        '      transactionDate'
        '      merchantTransactionId'
        '      paymentType'
        '    }'
        '    paging {'
        '      page'
        '      perPage'
        '      pagesCount'
        '      totalCount'
        '    }'
        '  }'
        '}'
        ''
      ].join('\n')
      assert.equal output, expected

  context 'when transactionType as array (Billing API multi-type filter)', ->
    it 'serializes transactionType array as GraphQL list', ->
      output = @builder.buildStructure({
        billingTransactions:
          filter:
            transactionType: ['Sale Approved', 'Refund Approved']
          fields: [
            { items: ['uniqueId'] }
          ]
      })
      assert.include output, 'transactionType: ["Sale Approved", "Refund Approved"]'

  context 'when invalid JavaScript numbers', ->
    it 'throws for NaN', ->
      fn = => @builder.buildStructure({ q: { filter: { val: NaN }, fields: ['id'] } })
      expect(fn).to.throw('Invalid GraphQL number')

    it 'throws for Infinity', ->
      fn = => @builder.buildStructure({ q: { filter: { val: Infinity }, fields: ['id'] } })
      expect(fn).to.throw('Invalid GraphQL number')

    it 'throws for -Infinity', ->
      fn = => @builder.buildStructure({ q: { filter: { val: -Infinity }, fields: ['id'] } })
      expect(fn).to.throw('Invalid GraphQL number')

  context 'when invalid field entries', ->
    it 'throws for numeric field entries', ->
      fn = => @builder.buildStructure({ q: { fields: [123] } })
      expect(fn).to.throw('Invalid GraphQL field selection')

    it 'throws for boolean field entries', ->
      fn = => @builder.buildStructure({ q: { fields: [true] } })
      expect(fn).to.throw('Invalid GraphQL field selection')

    it 'throws for null field entries', ->
      fn = => @builder.buildStructure({ q: { fields: [null] } })
      expect(fn).to.throw('Invalid GraphQL field selection')

    it 'throws when nested block value is not an array', ->
      fn = => @builder.buildStructure({ q: { fields: [{ items: 'uniqueId' }] } })
      expect(fn).to.throw('GraphQL field selection must be a non-empty array')

  context 'when invalid root query data', ->
    it 'throws for null root data', ->
      fn = => @builder.buildStructure({ billingTransactions: null })
      expect(fn).to.throw('GraphQL root query data must be an object')

    it 'throws for string root data', ->
      fn = => @builder.buildStructure({ billingTransactions: 'test' })
      expect(fn).to.throw('GraphQL root query data must be an object')

    it 'throws for array root data', ->
      fn = => @builder.buildStructure({ billingTransactions: [] })
      expect(fn).to.throw('GraphQL root query data must be an object')

  context 'when using Graphql.enum() alias', ->
    it 'outputs enum values unquoted (same as raw)', ->
      output = @builder.buildStructure({
        q:
          sort: { byDirection: Graphql.enum('desc') }
          fields: ['id']
      })
      assert.include output, 'byDirection: desc'
      assert.notInclude output, 'byDirection: "desc"'

    it 'validates enum values same as raw', ->
      fn = =>
        @builder.buildStructure({
          q:
            sort: { byDirection: Graphql.enum('invalid value!') }
            fields: ['id']
        })
      expect(fn).to.throw('Invalid GraphQL raw value')

    it 'rejects true, false and null as enum values', ->
      for val in ['true', 'false', 'null']
        fn = =>
          @builder.buildStructure({
            q:
              sort: { byDirection: Graphql.enum(val) }
              fields: ['id']
          })
        expect(fn).to.throw("Invalid GraphQL enum value: #{val}")

    it 'still accepts valid enum and raw values', ->
      output = @builder.buildStructure({
        q:
          sort: { a: Graphql.enum('DESC'), b: Graphql.raw('desc') }
          fields: ['id']
      })
      assert.include output, 'sort: { a: DESC, b: desc }'

  context 'when structural names are invalid', ->
    it 'throws for an invalid root query name', ->
      fn = => @builder.buildStructure({ 'invalid-query': { fields: ['id'] } })
      expect(fn).to.throw('Invalid GraphQL name')

    it 'throws for an invalid argument or input object key', ->
      fn = => @builder.buildStructure({
        q: { 'invalid-arg': { 'invalid-key': 'value' }, fields: ['id'] }
      })
      expect(fn).to.throw('Invalid GraphQL name')

    it 'throws for invalid field and nested block names', ->
      invalidField = => @builder.buildStructure({ q: { fields: ['invalid-field'] } })
      invalidBlock = => @builder.buildStructure({ q: { fields: [{ 'invalid-block': ['id'] }] } })
      expect(invalidField).to.throw('Invalid GraphQL name')
      expect(invalidBlock).to.throw('Invalid GraphQL name')

  context 'when field selections are empty or malformed', ->
    it 'throws when fields are missing or empty', ->
      missingFields = => @builder.buildStructure({ q: {} })
      emptyFields = => @builder.buildStructure({ q: { fields: [] } })
      expect(missingFields).to.throw('GraphQL field selection must be a non-empty array')
      expect(emptyFields).to.throw('GraphQL field selection must be a non-empty array')

    it 'throws when fields are not an array or nested fields are empty', ->
      stringFields = => @builder.buildStructure({ q: { fields: 'id' } })
      emptyNestedFields = => @builder.buildStructure({ q: { fields: [{ items: [] }] } })
      expect(stringFields).to.throw('GraphQL field selection must be a non-empty array')
      expect(emptyNestedFields).to.throw('GraphQL field selection must be a non-empty array')

    it 'throws when a nested field block contains multiple names', ->
      fn = => @builder.buildStructure({ q: { fields: [{ items: ['id'], paging: ['page'] }] } })
      expect(fn).to.throw('Invalid GraphQL field selection')