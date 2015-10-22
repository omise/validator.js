class OmiseCcNameValidation
  constructor: ->
    @_validates = new window.OmiseValidation.validates
    @_message   = new window.OmiseValidation.messages
    @_helper    = new window.OmiseValidation.helper

  ###
  # Initiate the validation event
  # @param {object} field - the field that be retrieved from @form variable
  # @param {string} field.target - a field name (might be a id or class name)
  # @param {object} field.validates - a validation class
  # @param {object} field.selector - a selector of a target field
  # @param {object} field.callback - a callback function
  # @param {object} response - the response handler class
  # @return {void}
  ###
  init: (field, response) =>
    field.selector.onkeydown = (e) =>
      e       = e || window.event
      e.which = e.which || e.keyCode || 0

      @_onkeydownEvent e, field, response

  ###
  # Validate an input
  # @param {string} value - a value that retrieve from typing
  # @param {string} [fieldValue=null] - a current field's value
  # @return {string|boolean}
  ###
  validate: (value, fieldValue = null) ->
    # Remove space before validate
    value = value.replace /\s/g, ''

    # Don't be an empty
    return @_message.get('emptyString') if @_validates.isEmpty value

    # Allow: only alphabet character [A-Za-z]
    return @_message.get('alphabetOnly') unless @_validates.isAlphabet value

    return true

  ###
  # Capture and handle on-key-down event
  # @param {object} e - an key event object
  # @param {object} field - the field that be retrieved from @form variable
  # @param {string} field.target - a field name (might be a id or class name)
  # @param {object} field.validates - a validation class
  # @param {object} field.selector - a selector of a target field
  # @param {object} field.callback - a callback function
  # @param {object} response - the response handler class
  # @return {boolean}
  ###
  _onkeydownEvent: (e, field, response) =>
    if e.metaKey is false and e.altKey is false and e.ctrlKey is false
      switch e.which
        # Allow: caps-lock, delete, tab, escape, home, end,
        # left-right arrow and spacebar
        when null, 0, 20, 9, 27, 32 then return true
        
        # Detect: backspace
        when 8
          e.preventDefault()

          if (@_helper.getCaretPosition(e.target)) isnt 0
            @_helper.delValFromCaretPosition e.target

          # Validate the field when it's dirty only
          if (@_helper.dirty(e.target)) is "true"
            response.result e, field, (@validate(e.target.value))
        
        else
          input = String.fromCharCode e.which
          value = e.target.value

          # Make the field dirty when type a character
          @_helper.beDirty e.target

          response.result e, field, (@validate(value + input))

# Export class
window.OmiseValidation.ccname = OmiseCcNameValidation
