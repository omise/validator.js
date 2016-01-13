class OmiseValidationRule
  isEmpty: (input) ->
    return input.length <= 0

  isDigit: (input) ->
    return /^\d+$/.test input

  isAlphabet: (input) ->
    return /^[a-z\.]+$/gi.test input

  isExpiry: (input) ->
    return /^(0[1-9]|1[0-2]) \/ ([0-9]{2}|[0-9]{4})$/.test input

  isExpiryYear: (input) ->
    return /^([0-9]{2}|[0-9]{4})$/.test input

  isExpiryMonth: (input) ->
    return /^(0[1-9]|1[0-2])$/.test input

  isCard: (cardType, input) ->
    jcb         = /^(?:2131|1800|35\d{3})\d{11}$/
    visa        = /^(?:4[0-9]{12}(?:[0-9]{3})?)$/
    mastercard  = /^(?:5[1-5][0-9]{14})$/

    switch cardType
      when 'jcb' then return jcb.test(input)
      when 'visa' then return visa.test(input)
      when 'mastercard' then return mastercard.test(input)
      else return false

# Export class
window.OmiseValidation.rules = OmiseValidationRule
