_            = require 'underscore'
js2xml   = require 'js2xmlparser'

class Xml

  ###
     Convert Object to XML structure
  ###
  objToXml: (structure) ->
    return '<?xml version=\'1.0\'?>' if _.isEmpty(structure)

    rootNode = _.first(_.keys(structure))

    js2xml.parse rootNode, structure[rootNode]

  ###
     Return object converter
  ###
  buildStructure: (structure) ->
    @objToXml structure


module.exports = Xml
