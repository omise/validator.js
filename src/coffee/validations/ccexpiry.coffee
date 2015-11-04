class OmiseCcExpiryValidation
  constructor: ->
    # Limitation of an input length
    @strLimit = 6

    # Field's display pattern (mm / YYYY)
    @pattern      = '## / ####'
    @format       = /^(0[1-9]|1[0-2]) \/ ([0-9]{2}|[0-9]{4})$/

  init: (field, dep) ->
    @validates = dep._validates
    @helper    = dep._helper
    @message   = dep._message
    @response  = dep._response

  _format: (value = "", input = "", caret = null) ->
    if value.length is 0 and /^[2-9]+$/.test input
      _value = "0#{input}"

    else if caret != value.length
      _value = value.split ''
      _value.splice caret, 0, input
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

  _reFormatExpiryPattern: (value = "", e) ->
    return value if value.length is 0

    value   = value.match /\d/g
    value   = value?.join "" || ""

    _value  = ""
    _pos    = 0
    _c      = 0

    for char, i in @pattern
      _c += 1
      if char is "#"
        if _pos < value.length
          _value += value[_pos]
          _pos += 1
        else
          break
      else
        _value += char

    caret           = e.target.selectionStart
    e.target.value  = _value

    # if caret > 4
    @helper.setCaretPosition e.target, (caret + (_value.length - caret))

    return _value

  ###
  # Validate an input
  # @param {string} value - a value that retrieve from typing
  # @param {string} [fieldValue=null] - a current field's value
  # @return {string|boolean}
  ###
  validate: (value, fieldValue = null) ->
    # Don't be an empty
    return @message.get('expiryEmpty') if @validates.isEmpty value

    # Allow: only digit character [0-9]
    return @message.get('expiryFormat') unless @validates.isExpiry value

    return true

  ###
  # Prevent the field from a word that will be invalid
  # @param {string} input - a value that retrieve from typing
  # @param {string} value - a current field's value
  # @return {boolean}
  ###
  _preventCharacter: (input, value) ->
    # Remove space before validate
    input = input.replace /\ \/\ /g, ''

    # Allow: only digit character [0-9]
    return false unless @validates.isDigit input

    # Length limit
    return false if input.length > @strLimit

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

    value   = value.match /\d/g
    value   = value?.join "" || ""

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
  # @return {boolean}
  ###
  onkeydownEvent: (e, field) =>
    if (@helper.isMetaKey(e)) is false
      # Allow: caps-lock, delete, tab, escape, home, end,
      # left-right, up-down arrows
      return true if e.which in [null, 0, 9, 13, 20, 27, 37, 38, 39, 40]

      # If press 'backspace'
      if e.which is 8
        e.preventDefault()

        if (pos = @helper.getCaretPosition(e.target)) != 0
          beDeleted = e.target.value[pos-1]

          switch (pos - 1)
            when 4, 3, 2
              pos = @helper.delValFromCaretPosition e.target, (pos - 1)
            
            else
              pos = @helper.delValFromCaretPosition e.target

          # Set formatted value
          e.target.value = @_reFormat e.target.value

          # Set new caret position
          @helper.setCaretPosition e.target, pos

        if @helper.dirty(e.target) is "true"
          @response.result e, field, (@validate(e.target.value))

      # If press any keys
      else
        input = @helper.inputChar e
        value = e.target.value
        caret = e.target.selectionStart

        if value.length is 0 and /^[2-9]+$/.test input
          input = "0#{input}"
          caret += 2
        else if caret is 1
          caret += 1

        return false unless (value = @_preventInput(input, value, e))

        e.preventDefault()
        
        @_reFormatExpiryPattern value, e
        
        if @helper.dirty e.target
          @response.result e, field, (@validate(e.target.value))

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

    # Allow: only digit character
    return false unless (value = @_preventInput(input, value, e))

    e.preventDefault()

    # Format the input value
    @_reFormatExpiryPattern value, e
    
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
  # @return {boolean}
  ###
  onblurEvent: (e, field) =>
    # Make the field dirty if these field's value is not empty
    if e.target.value.length > 0
      @helper.beDirty e.target

    if @helper.dirty e.target
      @response.result e, field, (@validate(e.target.value))

# Export class
window.OmiseValidation.ccexpiry = OmiseCcExpiryValidation
