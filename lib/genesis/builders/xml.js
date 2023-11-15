// Generated by CoffeeScript 2.7.0
(function() {
  var Xml, _, js2xml;

  _ = require('underscore');

  js2xml = require('js2xmlparser');

  Xml = class Xml {
    /*
       Convert Object to XML structure
    */
    objToXml(structure) {
      var rootNode;
      rootNode = _.first(_.keys(structure));
      return js2xml.parse(rootNode, structure[rootNode]);
    }

    /*
       Return object converter
    */
    getConverter(structure) {
      return this.objToXml(structure);
    }

  };

  module.exports = Xml;

}).call(this);