_ = require 'underscore'

class CardTypes

  ###
    The type of the issued card will be virtual
  ###
  @VIRTUAL = 'virtual';

  ###
    The type of the issued card will be physical
  ###
  @PHYSICAL = 'physical';

  getCardTypes: ->
    value for key, value of @constructor

  isValidCardType: (type) ->
    _.indexOf( @getCardTypes(), type ) != -1

module.exports = CardTypes