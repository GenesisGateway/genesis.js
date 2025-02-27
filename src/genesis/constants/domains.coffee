
class Domains

  @SUBDOMAINS : {
    "gate"         : {
      "production"        : "gate",
      "sandbox"           : "staging.gate"
    },
    "wpf"          : {
      "production"        : "wpf",
      "sandbox"           : "staging.wpf"
    },
    "smart_router" : {
      "production"        : "prod.api",
      "sandbox"           : "staging.api"
    },
    "kyc" : {
      "production"        : "kyc",
      "sandbox"           : "staging.kyc"
    }
  }

module.exports = Domains
