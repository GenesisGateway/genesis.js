faker = require 'faker'
_     = require 'underscore'

DigitalAssetTypes = () ->

  it 'not fail with digital_asset_types', ->
    data = _.clone @data
    digital_asset_type = faker.random.arrayElement(
      ["crypto", "cbdc", "stablecoin", "blockchain_native_token", "nft"]
    )
    data = _.extend(data, {'digital_asset_type': digital_asset_type})
    assert.equal true, @transaction.setData(data).isValid()

  it 'fail with invalid digital_asset_type', ->
    data = _.clone @data
    data = _.extend(data, {'digital_asset_type': 'invalid'})
    assert.equal false, @transaction.setData(data).isValid()

module.exports = DigitalAssetTypes
