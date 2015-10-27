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
  # @return {boolean}
  ###
  _preventCharacter: (input, value) ->
    # Length limit
    return false if (value + input).length > @strLimit

    # Allow: only digit character [0-9]
    return false unless @_validates.isDigit input

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
        # Allow: delete, tab, escape, home, end,
        # and left-right arrow
        when null, 0, 9, 27, 37, 39 then return true

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

          return false unless @_preventCharacter input, value

          if value.length is 0 and /^[2-9]+$/.test input
            e.preventDefault()
            value           = "0#{input}"
            e.target.value  = value
          else
            value = "#{value}#{input}"

          if @_helper.dirty(e.target) is "true"
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

    if @_helper.dirty(e.target) is "true"
      response.result e, field, (@validate(e.target.value))

# Export class
window.OmiseValidation.ccexpirymonth = OmiseCcExpiryMonthValidation
