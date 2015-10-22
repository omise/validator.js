class OmiseCcExpiryYearValidation
  constructor: ->
    @respMessage  = new window.OmiseValidation.messages
    @helper       = new window.OmiseValidation.helper

    # Limitation of an input length
    @strLimit = 4

  ###
  # Initiate the validation
  # @param {object} field - the field object (retrieve from @form variable)
  # @param {object} response - the response handler class
  # @return {void}
  ###
  init: (field, response) =>
    field.selector.onkeydown = (e) =>
      e = e || window.event
      @_onkeydownEvent field, e, response

  ###
  # Validation method
  # @param {string} value - a value that coming from typing
  # @param {string} fieldValue - a current field's value
  # @return {string|boolean}
  ###
  validate: (value, fieldValue = null) ->
    # Don't be an empty
    return @respMessage.get('emptyString') if value.length <= 0
    
    # Allow: only digit character [0-9]
    return @respMessage.get('digitOnly') if !/^\d+$/.test value

    return true

  ###
  # Prevent the field from a word that will be invalid
  # @param {string} input - a value that coming from typing
  # @param {string} value - a current field's value
  # @return {boolean}
  ###
  _preventCharacter: (input, value) ->
    # Length limit
    return false if (value + input).length > @strLimit

    # Allow: only digit character [0-9]
    return false if !/^\d+$/.test input

    return true

  ###
  # Capture and handle on-key-press event
  # @param {object} field - the field object (retrieve from @form variable)
  # @param {object} e - an key event object
  # @param {object} response - the response handler class
  # @return {boolean}
  ###
  _onkeydownEvent: (field, e, response) =>
    switch e.which
      # Allow: delete, tab, escape, home, end,
      # and left-right arrow
      when null, 0, 9, 27 then return true

      # Detect: backspace
      when 8
        e.preventDefault()

        if (@helper.getCaretPosition(e.target)) != 0
          @helper.delValFromCaretPosition e.target

        # Validate the field when it's dirty only
        if (@helper.dirty(e.target)) is "true"
          response.result e, field, (@validate(e.target.value))

      else
        # Make the field dirty when type a character
        @helper.beDirty e.target

        input = String.fromCharCode e.which
        value = e.target.value

        return false unless @_preventCharacter input, value

        response.result e, field, (@validate(value + input))

# Export class
window.OmiseValidation.ccexpiryyear = OmiseCcExpiryYearValidation
