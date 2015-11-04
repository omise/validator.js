class OmiseCcSecurityCodeValidation
  constructor: ->
    # Limitation of an input length
    @strMin = 3
    @strLimit = 4

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
    # Don't be an empty
    return @message.get('emptyString') if @validates.isEmpty value

    # Allow: only digit character [0-9]
    return @message.get('digitOnly') unless @validates.isDigit value

    # Allow: only digit character [0-9]
    return @message.get('securitycodeMin') if value.length < @strMin

    # Allow: only digit character [0-9]
    return @message.get('securitycodeMax') if value.length > @strLimit

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
    return false unless @validates.isDigit input

    caret = e.target.selectionStart
    if (range = @helper.caretRange(e.target)) isnt ""

      p1    = value.slice(0, caret)
      p2    = value.slice(caret + range.length)

      value = p1 + input + p2
    else
      value = @helper.insertValAfterCaretPos value, input, caret

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
  onkeydownEvent: (e, field) =>
    if (@helper.isMetaKey(e)) is false
      # Allow: caps-lock, delete, tab, escape, home, end,
      # left-right, up-down arrows
      return true if e.which in [null, 0, 9, 13, 20, 27, 37, 38, 39, 40]

      if e.which isnt 8
        input = @helper.inputChar e
        value = e.target.value

        return false unless @_preventInput input, value, e

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
  # @param {object} response - the response handler class
  # @return {boolean}
  ###
  onpasteEvent: (e, field) =>
    input = e.clipboardData.getData 'text/plain'
    value = e.target.value

    return false unless (value = @_preventInput(input, value, e))

    # Make the field dirty when type a character
    @helper.beDirty e.target

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
  onblurEvent: (e, field) =>
    # Make the field dirty if these field's value is not empty
    if e.target.value.length > 0
      @helper.beDirty e.target

    if @helper.dirty e.target
      @response.result e, field, (@validate(e.target.value))

# Export class
window.OmiseValidation.ccsecuritycode = OmiseCcSecurityCodeValidation
