class OmiseCcExpiryMonthValidation
  constructor: ->
    @_validates = new window.OmiseValidation.validates
    @_message   = new window.OmiseValidation.messages
    @_helper    = new window.OmiseValidation.helper

    # Limitation of an input length
    @strLimit = 2

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
    # Don't be an empty
    return @_message.get('expiryEmpty') if @_validates.isEmpty value

    # Allow: only digit character [0-9]
    return @_message.get('digitOnly') unless @_validates.isDigit value

    # Allow: only digit character [0-9]
    return @_message.get('expiryFormat') unless @_validates.isExpiryMonth value

    return true

  ###
  # Prevent the field from a word that will be invalid
  # @param {string} input - a value that retrieve from typing
  # @param {string} value - a current field's value
  # @param {object} e - an key event object
  # @return {boolean}
  ###
  _preventInput: (input, value, e) ->
    # Allow: only digit character [0-9]
    return false unless @_validates.isDigit input

    caret = e.target.selectionStart
    if (range = @_helper.caretRange(e.target)) isnt ""

      p1    = value.slice(0, caret)
      p2    = value.slice(caret + range.length)

      value = p1 + input + p2
    else
      value = @_helper.insertValAfterCaretPos value, input, caret

    # Length limit
    return false if value.length > @strLimit

    return value

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
      return true if e.which in [null, 0, 9, 13, 20, 27, 37, 38, 39, 40]

      if e.which isnt 8
        input = @_helper.inputChar e
        value = e.target.value

        return false unless @_preventInput input, value, e

        if value.length is 0 and /^[2-9]+$/.test input
          e.preventDefault()
          value           = "0#{input}"
          e.target.value  = value

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

    return false unless (value = @_preventInput(input, value, e))

    # Make the field dirty when type a character
    @_helper.beDirty e.target

    response.result e, field, (@validate(value))

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
window.OmiseValidation.ccexpirymonth = OmiseCcExpiryMonthValidation
