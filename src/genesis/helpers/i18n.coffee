_ = require 'underscore'

class i18n
  ###
    Arabic locale and language
  ###
  @AR = 'Arabic';

  ###
    Bulgarian locale and language
  ###
  @BG = 'Bulgarian';

  ###
    German locale and language
  ###
  @DE = 'German';

  ###
    English locale and language settings (this is the default)
  ###
  @EN = 'English';

  ###
    Spanish locale and language settings
  ###
  @ES = 'Spanish';

  ###
    French locale and language settings
  ###
  @FR = 'French';

  ###
    Hindu locale and language
  ###
  @HI = 'Hindu';

  ###
    Japanese locale and language
  ###
  @JA = 'Japanese';

  ###
    Icelandic locale and language
  ###
  @IS = 'Icelandic';

  ###
    Italian locale and language settings
  ###
  @IT = 'Italian';

  ###
    Dutch locale and language
  ###
  @NL = 'Dutch';

  ###
    Portuguese locale and language
  ###
  @PT = 'Portuguese';

  ###
    Polish locale and language
  ###
  @PL = 'Polish';

  ###
    Russian locale and language
  ###
  @RU = 'Russian';

  ###
    Turkish locale and language
  ###
  @TR = 'Turkish';

  ###
    Mandarin Chinese locale and language
  ###
  @ZH = 'Chinese (Mandarin)';

  getLocales: ->
    key.toLowerCase() for key, value of @constructor

  isValidLocale: (locale) ->
    _.indexOf( @getLocales(), locale.toLowerCase() ) != -1

module.exports = i18n