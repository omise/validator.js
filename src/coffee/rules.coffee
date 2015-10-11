class OmiseValidationRules
  constructor: ->
    # Initiate validation classes
    @ccNameValidation     = new window.OmiseValidation.ccname
    @ccNumberValidation   = new window.OmiseValidation.ccnumber
    @ccExpiryValidation   = new window.OmiseValidation.ccexpiry
    @ccSecureValidation   = new window.OmiseValidation.ccsecure

    # # Mapping rules with classes
    @rules =
      ccName        : @ccNameValidation.defaultRule
      ccNumber      : @ccNumberValidation.defaultRule
      ccExpiry      : @ccExpiryValidation.defaultRule
      ccExpiryMonth : @ccExpiryValidation.expiryMonthRule
      ccExpiryYear  : @ccExpiryValidation.expiryYearRule
      ccSecure      : @ccSecureValidation.defaultRule

  getRule: (keyName) ->
    return rule = @rules[keyName] or false

# Export class
window.OmiseValidation.rules = OmiseValidationRules