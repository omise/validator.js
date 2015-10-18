class OmiseCcExpiryValidation
  constructor: ->
    @respMessage  = new window.OmiseValidation.messages
    @helper       = new window.OmiseValidation.helper

    # Limitation of an input length
    @strLimit = 6

    # Field's display pattern (mm / YYYY)
    @pattern      = '## / ####'
    @format       = /^(0[1-9]|1[0-2]) \/ ([0-9]{2}|[0-9]{4})$/
    @formatMonth  = /^(0[1-9]|1[0-2])/
    @formatYear   = /([0-9]{2}|[0-9]{4})$/

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

    field.selector.onblur = (e) =>
      e = e || window.event
      @_onblurEvent field, e, response


  ###
  # Validation method
  # @param {string} value - an input value
  # @param {string} fieldValue - a current value
  # @return {void}
  ###
  validate: (value, fieldValue = "") ->
    # Don't be an empty
    return @respMessage.get('emptyString') if value.length <= 0

    # Must match with card's expiry pattern
    return @respMessage.get('expiryFormat') if !@format.test value

    return true

  ###
  # Validation for form submit event
  # @param {string} value - an input value
  # @return {void}
  ###
  submitValidate: (value) ->
    # Don't be an empty
    return @respMessage.get('emptyString') if value.length <= 0

    return @respMessage.get('expiryFormat') if !@format.test value

    return true

  _preventCharacter: (value) ->
    # Remove space before validate
    value = value.replace /\ \/\ /g, ''

    # Allow: only digit character [0-9]
    return false if !/^\d+$/.test value

    # Length limit
    return false if value.length > @strLimit

    return true

  _format: (value = "", input = "", caret = null) ->
    if value.length is 0 and /^[2-9]+$/.test input
      _value = "0#{input}"

    else if caret != value.length
      _value = value.split ''
      _value.splice(caret, 0, input);
      _value = _value.join ''

      _value = _value.match /\d/g
      _value = _value.join ''

    else
      _value = "#{value}#{input}"

    return @_reFormat _value

  _reFormat: (value = "") ->
    return value if value.length is 0

    value   = value.match /\d/g
    value   = value?.join "" || ""

    _value  = ""
    _pos    = 0

    for char, i in @pattern
      if char is "#"
        if _pos < value.length
          _value += value[_pos]
          _pos += 1
        else
          break
      else
        _value += char

    return _value

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
      # and left-right arrow
      when null, 0, 9, 27 then return true

      # Detect: backspace
      when 8
        e.preventDefault()

        @helper.deleteValueFromCaretPosition e.target

        e.target.value = @_reFormat e.target.value

        if @helper.dirty(e.target) is "true"
          response.result field, (@validate(e.target.value))

      else
        e.preventDefault()

        # Validate the field when it's dirty only
        input = String.fromCharCode e.which
        value = e.target.value

        # Allow: only digit character
        return false if @_preventCharacter(value + input) is false

        # Format the input value
        caret           = e.target.selectionStart
        e.target.value  = @_format value, input, caret

        if caret > 4
          @helper.setCaretPosition e.target, caret + 1

        if @helper.dirty(e.target) is "true"
          response.result field, (@validate(e.target.value))

  ###
  # Capture and handle on-blur event
  # @param {object} field - the field object (retrieve from @form variable)
  # @param {object} e - an key event object
  # @param {object} response - the response handler class
  # @return {boolean}
  ###
  _onblurEvent: (field, e, response) =>
    # Make the field dirty if these field's value is not empty
    if e.target.value.length > 0
      @helper.beDirty e.target

    return

# Export class
window.OmiseValidation.ccexpiry = OmiseCcExpiryValidation
