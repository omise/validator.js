class OmiseCcNameValidation
  constructor: ->
    @respMessage  = new window.OmiseValidation.messages
    @helper       = new window.OmiseValidation.helper

  ###
  # Initiate a validation
  # @param {object} field - the field object (retrieve from @form variable)
  # @param {object} response - the response handler class
  # @return {void}
  ###
  init: (field, response) =>
    field.selector.onkeypress = (e) =>
      e = e || window.event
      @_onkeypressEvent field, e, response

  ###
  # Validation method
  # @param {string} value - an input value
  # @param {string} fieldValue - a current value
  # @return {void}
  ###
  validate: (value, fieldValue = null) ->
    # Remove space before validate
    value = value.replace /\s/g, ''

    # Don't be an empty
    return @respMessage.get('emptyString') if value.length <= 0

    # Allow: only alphabet character [A-Za-z]
    return @respMessage.get('alphabetOnly') if !/^[a-z]+$/gi.test value

    return true

  ###
  # Validation for form submit event
  # @param {string} value - an input value
  # @return {void}
  ###
  submitValidate: (value) ->
    # Don't be an empty
    return @respMessage.get('emptyString') if value.length <= 0

    return true

  ###
  # Capture and handle on-key-press event
  # @param {object} field - the field object (retrieve from @form variable)
  # @param {object} e - an key event object
  # @param {object} response - the response handler class
  # @return {boolean}
  ###
  _onkeypressEvent: (field, e, response) =>
    switch e.which
      # Allow: delete, tab, escape, home, end,
      # left-right arrow and spacebar
      when null, 0, 9, 27, 32 then return true
      
      # Detect: backspace
      when 8
        # Validate the field when it's dirty only
        if @helper.dirty(e.target) is "true"
          e.preventDefault()

          @helper.deleteValueFromCaretPosition e.target
        
          response.result field, (@validate(e.target.value))
      
      else
        # Make the field dirty when type a character
        @helper.beDirty e.target

        input = String.fromCharCode e.which
        value = e.target.value

        response.result field, (@validate(value + input))

# Export class
window.OmiseValidation.ccname = OmiseCcNameValidation
