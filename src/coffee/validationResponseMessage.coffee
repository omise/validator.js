class OmiseValidationResponseMessage
  constructor: ->
    @messages =
      emptyString   : 'The value must not be an empty'
      alphabetOnly  : 'The value must be a alphabet character only'
      digitOnly     : 'The value must be a digit character only'

  ###
  # Get a response message
  # @param {string} code - a response message code
  # @return {string} a response message 
  ###
  get: (code) ->
    return @messages[code] || 'invalid'

# Export class
window.OmiseValidation.messages = OmiseValidationResponseMessage