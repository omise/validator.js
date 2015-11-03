class OmiseValidationMessage
  constructor: ->
    @messages =
      emptyString       : 'The value must not be an empty'
      alphabetOnly      : 'The value must be a alphabet character only'
      digitOnly         : 'The value must be a digit character only'

      nameEmpty         : 'Name on card cannot be empty'
      nameAlphabet      : 'Name on card must only contains letters'

      cardEmpty         : 'Card number cannot be empty'
      cardFormat        : 'Card number is invalid'
      cardNotMatch      : 'Card number is invalid'

      expiryEmpty       : 'Expiration cannot be empty'
      expiryFormat      : 'Expiration is invalid'
      
      securitycodeMin   : 'Code must be greater or equal to 3 characters'
      securitycodeMax   : 'Code must be less or equal to 4 characters'

  ###
  # Get a response message
  # @param {string} code - a response message code
  # @return {string} a response message
  ###
  get: (code) ->
    return @messages[code] || 'invalid'

# Export class
window.OmiseValidation.messages = OmiseValidationMessage
