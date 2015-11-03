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

    field.selector.onkeyup = (e) =>
      e       = e || window.event
      e.which = e.which || e.keyCode || 0
      @_onkeyupEvent e, field, response

    field.selector.onpaste = (e) =>
      e       = e || window.event
      e.which = e.which || e.keyCode || 0
      @_onpasteEvent e, field, response

    field.selector.onblur = (e) =>
      e       = e || window.event
      e.which = e.which || e.keyCode || 0
      @_onblurEvent e, field, response

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
    return @_message.get('nameEmpty') if @_validates.isEmpty value

    # Allow: only alphabet character [A-Za-z]
    return @_message.get('nameAlphabet') unless @_validates.isAlphabet value

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
    if (@_helper.isMetaKey(e)) is false
      # Allow: caps-lock, delete, tab, escape, home, end,
      # left-right, up-down arrows
      return true if e.which in [null, 0, 9, 20, 27, 37, 38, 39, 40]

      if e.which isnt 8
        # Make the field dirty
        @_helper.beDirty e.target

  ###
  # Capture and handle on-key-up event
  # @param {object} e - an key event object
  # @param {object} field - the field that be retrieved from @form variable
  # @param {string} field.target - a field name (might be a id or class name)
  # @param {object} field.validates - a validation class
  # @param {object} field.selector - a selector of a target field
  # @param {object} field.callback - a callback function
  # @param {object} response - the response handler class
  # @return {boolean}
  ###
  _onkeyupEvent: (e, field, response) =>
    if @_helper.dirty e.target
      response.result e, field, (@validate(e.target.value))

  ###
  # Capture and handle on-paste event
  # @param {object} e - an key event object
  # @param {object} field - the field that be retrieved from @form variable
  # @param {string} field.target - a field name (might be a id or class name)
  # @param {object} field.validates - a validation class
  # @param {object} field.selector - a selector of a target field
  # @param {object} field.callback - a callback function
  # @param {object} response - the response handler class
  # @return {boolean}
  ###
  _onpasteEvent: (e, field, response) =>
    input = e.clipboardData.getData 'text/plain'
    value = e.target.value

    # Make the field dirty when type a character
    @_helper.beDirty e.target

    response.result e, field, (@validate(value + input))

  ###
  # Capture and handle on-blur event
  # @param {object} e - an key event object
  # @param {object} field - the field that be retrieved from @form variable
  # @param {string} field.target - a field name (might be a id or class name)
  # @param {object} field.validates - a validation class
  # @param {object} field.selector - a selector of a target field
  # @param {object} field.callback - a callback function
  # @param {object} response - the response handler class
  # @return {boolean}
  ###
  _onblurEvent: (e, field, response) =>
    # Make the field dirty if these field's value is not empty
    if e.target.value.length > 0
      @_helper.beDirty e.target

    if @_helper.dirty e.target
      response.result e, field, (@validate(e.target.value))

# Export class
window.OmiseValidation.ccname = OmiseCcNameValidation
