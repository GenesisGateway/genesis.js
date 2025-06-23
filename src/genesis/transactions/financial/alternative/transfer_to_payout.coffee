
AlternativeBase  = require './alternative_base'
TransactionTypes = require '../../../helpers/transaction/types'

###
  TransferTo Payout is an APM which provides 3 different payment services: BankAccount,
  MobileWallet and CashPickup
###
class TransferToPayout extends AlternativeBase

  getTransactionType: ->
    TransactionTypes.TRANSFER_TO_PAYOUT

module.exports = TransferToPayout
