path = require('path')

i18n = require path.resolve './src/genesis/helpers/i18n'

describe 'Locales', ->

  before ->
    @i18n = new i18n()

  it 'returns array when locales are requested', ->
    assert.isArray @i18n.getLocales()

  it 'returns false when invalid locale is passed', ->
    assert.equal false, @i18n.isValidLocale 'not_valid_locale'

