###
Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NON-INFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.

@license http://opensource.org/licenses/MIT The MIT License
###

fs   = require 'fs'
path = require 'path'

# Schema autoloader.
#
# Discovers the JSON schema files on disk relative to this module (never
# process.cwd(), so resolution works when genesis.js is an installed
# dependency) and exposes two operations for the validator:
#
#   registerDefinitions(ajv) - register every shared definition/attribute
#     schema under schemas/definitions/ so $ref resolution succeeds.
#   loadTransactionSchema(transactionType) - resolve a per-transaction schema
#     by its flat transaction-type string, regardless of the subdirectory the
#     file now lives in.
#
# The transaction index is keyed on the transaction-type string (the file name
# without the .json extension), because that string is the only key the
# validator has at lookup time and some filenames differ from their class name.
class SchemaLoader

  # schemas/ lives three levels up from this module (lib/genesis/transactions/
  # or src/genesis/transactions/).
  @SCHEMAS_DIR: path.join __dirname, '..', '..', '..', 'schemas'
  @DEFINITIONS_DIR: path.join @SCHEMAS_DIR, 'definitions'
  @TRANSACTIONS_DIR: path.join @SCHEMAS_DIR, 'transactions'

  # Recursively collect every *.json file under the given directory.
  @collectJsonFiles: (dir) ->
    files = []
    return files unless fs.existsSync dir

    for entry in fs.readdirSync dir, withFileTypes: true
      full = path.join dir, entry.name
      if entry.isDirectory()
        files = files.concat @collectJsonFiles full
      else if entry.isFile() and entry.name.endsWith '.json'
        files.push full

    files

  # Build (once) the transaction-type -> absolute file path index.
  # Fails fast if two files would resolve to the same transaction type.
  @getTransactionIndex: () ->
    return @_transactionIndex if @_transactionIndex?

    index = {}
    for file in @collectJsonFiles @TRANSACTIONS_DIR
      type = path.basename file, '.json'
      if index[type]?
        throw new Error(
          "Duplicate transaction schema for type '#{type}': " +
          "#{index[type]} and #{file}"
        )
      index[type] = file

    @_transactionIndex = index

  # Register every definitions/attributes schema on the given AJV instance.
  @registerDefinitions: (ajv) ->
    for file in @collectJsonFiles @DEFINITIONS_DIR
      ajv.addSchema require file

    ajv

  # Resolve a transaction schema object by its flat transaction type string.
  # Throws when no schema is mapped for the type; the caller preserves the
  # existing "JSON schema not found" behavior.
  @loadTransactionSchema: (transactionType) ->
    file = @getTransactionIndex()[transactionType]
    throw new Error(
      "JSON schema not found for transaction type '#{transactionType}'"
    ) unless file?

    require file

module.exports = SchemaLoader
