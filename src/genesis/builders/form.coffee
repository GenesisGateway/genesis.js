_            = require 'underscore'

class Form

  #  Convert Object to URL-encoded query string structure
  objToQueryString: (structure) ->
    new URLSearchParams(structure)

  # Return object converter
  getConverter: (structure) ->
    @objToQueryString structure

module.exports = Form
