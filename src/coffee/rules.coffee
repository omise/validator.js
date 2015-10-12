class OmiseValidationRules
  constructor: ->
    # Initiate validation classes
    @rules =
      ccName        : new window.OmiseValidation.ccname
      ccNumber      : new window.OmiseValidation.ccnumber
      ccExpiry      : new window.OmiseValidation.ccexpiry
      ccExpiryMonth : new window.OmiseValidation.ccexpirymonth
      ccExpiryYear  : new window.OmiseValidation.ccexpiryyear
      ccSecure      : new window.OmiseValidation.ccsecure

  getRule: (keyName) ->
    return rule = @rules[keyName] or false

# Export class
window.OmiseValidation.rules = OmiseValidationRules