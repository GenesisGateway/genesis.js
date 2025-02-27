chai  = require 'chai'
sinon = require 'sinon'
chai.use(require('sinon-chai'))
chai.config.includeStack = true

global.expect         = chai.expect
global.AssertionError = chai.AssertionError
global.Assertion      = chai.Assertion
global.assert         = chai.assert
global.sinon          = sinon
