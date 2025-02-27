_            = require 'underscore'

class Form

  #  Convert Object to URL-encoded query string structure
  objToQueryString: (structure) ->
    (new URLSearchParams(structure)).toString()

  # Return object converter
  buildStructure: (structure) ->
    @objToQueryString structure

module.exports = Form
