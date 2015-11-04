class OmiseCcNameValidation
  init: (field, dep) ->
    @validates = dep._validates
    @helper    = dep._helper
    @message   = dep._message
    @response  = dep._response

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
    return @message.get('nameEmpty') if @validates.isEmpty value

    # Allow: only alphabet character [A-Za-z]
    return @message.get('nameAlphabet') unless @validates.isAlphabet value

    return true

  ###
  # Capture and handle on-key-down event
  # @param {object} e - an key event object
  # @param {object} field - the field that be retrieved from @form variable
  # @param {string} field.target - a field name (might be a id or class name)
  # @param {object} field.validates - a validation class
  # @param {object} field.selector - a selector of a target field
  # @param {object} field.callback - a callback function
  # @return {boolean}
  ###
  onkeydownEvent: (e, field) =>
    if (@helper.isMetaKey(e)) is false
      # Allow: caps-lock, delete, tab, escape, home, end,
      # left-right, up-down arrows
      return true if e.which in [null, 0, 9, 20, 27, 37, 38, 39, 40]

      if e.which isnt 8
        # Make the field dirty
        @helper.beDirty e.target

  ###
  # Capture and handle on-key-up event
  # @param {object} e - an key event object
  # @param {object} field - the field that be retrieved from @form variable
  # @param {string} field.target - a field name (might be a id or class name)
  # @param {object} field.validates - a validation class
  # @param {object} field.selector - a selector of a target field
  # @param {object} field.callback - a callback function
  # @return {boolean}
  ###
  onkeyupEvent: (e, field) =>
    if @helper.dirty e.target
      @response.result e, field, (@validate(e.target.value))

  ###
  # Capture and handle on-paste event
  # @param {object} e - an key event object
  # @param {object} field - the field that be retrieved from @form variable
  # @param {string} field.target - a field name (might be a id or class name)
  # @param {object} field.validates - a validation class
  # @param {object} field.selector - a selector of a target field
  # @param {object} field.callback - a callback function
  # @return {boolean}
  ###
  onpasteEvent: (e, field) =>
    input = e.clipboardData.getData 'text/plain'
    value = e.target.value

    # Make the field dirty when type a character
    @helper.beDirty e.target

    @response.result e, field, (@validate(value + input))

  ###
  # Capture and handle on-blur event
  # @param {object} e - an key event object
  # @param {object} field - the field that be retrieved from @form variable
  # @param {string} field.target - a field name (might be a id or class name)
  # @param {object} field.validates - a validation class
  # @param {object} field.selector - a selector of a target field
  # @param {object} field.callback - a callback function
  # @return {boolean}
  ###
  onblurEvent: (e, field) =>
    # Make the field dirty if these field's value is not empty
    if e.target.value.length > 0
      @helper.beDirty e.target

    if @helper.dirty e.target
      @response.result e, field, (@validate(e.target.value))

# Export class
window.OmiseValidation.ccname = OmiseCcNameValidation
