_ = require 'underscore'

class I18n
  ###
    English locale and language settings (this is the default)
  ###
  @EN = 'English'

  ###
    Italian locale and language settings
  ###
  @IT =	'Italian'

  ###
    Spanish locale and language settings
  ###
  @ES	 = 'Spanish'

  ###
    French locale and language settings
  ###
  @FR	= 'French'

  ###
    German locale and language
  ###
  @DE	= 'German'

  ###
    Polish locale and language
  ###
  @PL	= 'Polish'

  ###
    Japanese locale and language
  ###
  @JA =	'Japanese'

  ###
    Mandarin Chinese locale and language
  ###
  @ZH =	'Chinese (Mandarin)'

  ###
    Arabic locale and language
  ###
  @AR	= 'Arabic'

  ###
    Portuguese locale and language
  ###
  @PT =	'Portuguese'

  ###
    Turkish locale and language
  ###
  @TR =	'Turkish'

  ###
    Russian locale and language
  ###
  @RU =	'Russian'

  ###
    Hindu locale and language
  ###
  @HI =	'Hindu'

  ###
    Bulgarian locale and language
  ###
  @BG =	'Bulgarian'

  ###
    Dutch locale and language
  ###
  @NL =	'Dutch'

  ###
    Icelandic locale and language
  ###
  @IS =	'Icelandic'

  ###
    Indonesian locale and language
  ###
  @ID =	'Indonesian'

  ###
    Malay locale and language
  ###
  @MS =	'Malay'

  ###
    Thai locale and language
  ###
  @TH =	'Thai'

  ###
    Czech locale and language
  ###
  @CS = 'Czech'

  ###
    Croatian locale and language
  ###
  @HR =	'Croatian'

  ###
    Slovenian locale and language
  ###
  @SL =	'Slovenian'

  ###
    Finnish locale and language
  ###
  @FI =	'Finnish'

  ###
    Norwegian locale and language
  ###
  @NO =	'Norwegian'

  ###
    Danish locale and language
  ###
  @DA =	'Danish'

  ###
    Swedish locale and language
  ###
  @SV =	'Swedish'

  getLocales: ->
    key.toLowerCase() for key, value of @constructor

  isValidLocale: (locale) ->
    _.indexOf( @getLocales(), locale.toLowerCase() ) != -1

module.exports = I18n
