Request = require '../../request'

###
  Base class for GraphQL-based Billing API requests.

  - Authenticates with `Authorization: Bearer <billing_api_token>` instead of Basic auth
  - Validates the configuration against schemas/config/graphql_config.json
    (customer.billing_api_token is required and non-empty)
  - Builds the GraphQL document once in isValid() and dispatches exactly that document
  - Rejects an empty query structure
  - Opt-in transaction schema validation: a subclass that defines getTransactionType()
    is also validated against schemas/<transaction_type>.json

  Subclasses must override getUrl() and buildQueryStructure().
###
class GraphqlBase extends Request

  constructor: (params, configuration) ->
    super(params, configuration, 'graphql')

  # Subclasses must override this to define the API endpoint
  getUrl: ->
    throw new Error('GraphQL request must define getUrl()')

  getTrxData: ->
    @buildQueryStructure()

  # Validate GraphQL configuration and query structure before sending
  # On success the built document is cached in @document for dispatch
  isValid: ->
    @document = null

    return false unless @validator.isValidGraphqlConfig()

    @sanitizeParams(@params)

    return false unless @isValidParams()

    try
      document = @builderContext.getDocument(@getTrxData())
    catch error
      @validator.addError message: error.message
      return false

    if document == ''
      @validator.addError message: 'GraphQL query structure must not be empty'
      return false

    @document = document

    true

  # Transaction schema validation hook
  # Runs only when the subclass defines getTransactionType()
  isValidParams: ->
    return true unless typeof @getTransactionType == 'function'

    @validator.isValid()

  # Dispatch the document built and validated in isValid()
  getArguments: ->
    url:
      @getUrl()
    trx:
      @document

  # The cached document is already serialized
  getRequestBody: (document) ->
    document

  # Override in subclasses to define query structure
  buildQueryStructure: ->
    {}

  # Billing API uses Bearer token authentication, not Basic auth
  getAuthorizationHeader: ->
    "Bearer #{@configuration.getBillingApiToken()}"

module.exports = GraphqlBase
