path = require('path');

Country = require path.resolve './src/genesis/helpers/country'

describe 'Country', ->

  before ->
    @country = new Country()

  it 'returns array when countries are requested', ->
    assert.isArray @country.getCountries()
