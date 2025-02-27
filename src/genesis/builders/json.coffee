
class Json

  ###
     Convert Object to JSON structure
  ###
  objToJSON: (structure) ->
    JSON.stringify(structure)

  ###
     Return object converter
  ###
  buildStructure: (structure) ->
    @objToJSON structure

module.exports = Json
