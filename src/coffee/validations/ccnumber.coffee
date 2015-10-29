class OmiseCcNumberValidation
  constructor: ->
    @_validates = new window.OmiseValidation.validates
    @_message   = new window.OmiseValidation.messages
    @_helper    = new window.OmiseValidation.helper

    # List of card that be accepted
    @cards = [
        type      : 'mastercard'
        pattern   : /^5[1-5]/
        format    : '#### #### #### ####'
        length    : 16
        icon      : 'http://cdn.omise.co/validator/images/icon-mastercard.png'
        validate  : /(?:^|\s)(\d{4})$/
      ,
        type      : 'visa'
        pattern   : /^4/
        format    : '#### #### #### ####'
        length    : 16
        icon      : 'http://cdn.omise.co/validator/images/icon-visa.png'
        validate  : /(?:^|\s)(\d{4})$/
      ,
        type      : 'visa_old'
        pattern   : /^4/
        format    : '#### ### ### ###'
        length    : 13
        icon      : 'http://cdn.omise.co/validator/images/icon-visa.png'
    ]

    @cardUnknow =
      type        : 'unknow'
      format      : '#### #### #### ####'
      length      : 16

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
    # Initiate credit card icon
    @_appendCcIcon field.selector

    field.selector.onkeydown = (e) =>
      e       = e || window.event
      e.which = e.which || e.keyCode || 0

      @_onkeydownEvent e, field, response

    field.selector.onblur = (e) =>
      e       = e || window.event
      e.which = e.which || e.keyCode || 0

      @_onblurEvent e, field, response

    field.selector.onpaste = (e) =>
      e       = e || window.event
      e.which = e.which || e.keyCode || 0

      @_onpasteEvent e, field, response

  ###
  # Validate an input
  # @param {string} value - a value that coming from typing
  # @param {string} fieldValue - a current field's value
  # @return {string|boolean}
  ###
  validate: (value, fieldValue = "") ->
    value = (value + '').replace(/\D/g, '')

    # Don't be an empty
    return @_message.get('cardEmpty') if @_validates.isEmpty value

    c = @_validateCardPattern value
    return @_message.get('cardNotMatch') unless c?

    return @_message.get('cardFormat') unless @_validates.isCard c.type, value

    return true

  ###
  # Create a credit card icon's element
  # @param {object} elem - a selector object of an element
  # @return {void}
  ###
  _appendCcIcon: (elem) ->
    parent = elem.parentNode
    
    for card, i in @cards
      e           = document.createElement 'img'
      e.src       = card.icon
      e.className = "omise_ccnumber_card omise_ccnumber_#{card.type}"
    
      parent.appendChild e

  ###
  # Validate input card pattern
  # @param {string} num   - An input card number
  # @return {array}
  ###
  _validateCardPattern: (num) ->
    num = (num + '').replace(/\D/g, '')

    return _card for _card in @cards when _card.pattern.test(num) is true

  _format: (value = "", input = "", card, caret = null) ->
    if caret != value.length
      _value = value.split ''
      _value.splice caret, 0, input
      _value = _value.join ''

      _value = _value.match /\d/g
      _value = _value.join ''

    else
      _value = "#{value}#{input}"

    return @_reFormat _value, card

  ###
  # Validate input card pattern
  # @param {string} num   - An input card number
  # @return {string} formatted value
  ###
  _reFormat: (value = "", card) ->
    return value if value.length is 0

    value   = value.match /\d/g
    value   = value?.join "" || ""

    _value  = ""
    _pos    = 0

    for char, i in card.format
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
  # Show a valid credit card logo
  # @param {object} elem - an target element
  # @param {object} cardTarget - one of cardAcceptance object
  # @return {void}
  ###
  _show: (elem, cardTarget) ->
    @_hide elem

    className = "omise_ccnumber_#{cardTarget.type}"
    target = elem.parentNode.getElementsByClassName className
    if target.length isnt 0
      target = target[0]
      target.className = target.className + " valid"

  ###
  # Hide all of credit card icons
  # @param {object} elem - an target element
  # @return {void}
  ###
  _hide: (elem) ->
    cards = elem.parentNode.getElementsByClassName "omise_ccnumber_card"
    for card in cards
      card.className = card.className.replace /valid/gi, ""

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

          if (pos = @_helper.getCaretPosition(e.target)) != 0
            beDeleted = e.target.value[pos-1]

            if /\s/.test beDeleted
              pos = @_helper.delValFromCaretPosition e.target, 2
            else
              pos = @_helper.delValFromCaretPosition e.target

            card  = @_validateCardPattern(e.target.value) || @cardUnknow

            if card.type is 'unknow'
              @_hide e.target
            else
              @_show e.target, card
          
            # Set formatted value
            e.target.value = @_reFormat e.target.value, card

            # Set new caret position
            @_helper.setCaretPosition e.target, pos

          if @_helper.dirty(e.target) is "true"
            response.result e, field, (@validate(e.target.value))

        else
          # Validate the field when it's dirty only
          input = String.fromCharCode e.which
          value = e.target.value

          e.preventDefault()

          # Allow: only digit character [0-9]
          return false if !/^\d+$/.test input

          card        = @_validateCardPattern("#{value}#{input}") || @cardUnknow
          cardLength  = card.length
          inputLength = (value.replace(/\D/g, '') + input).length

          if card.type is 'unknow'
            @_hide e.target
          else
            @_show e.target, card
          
          return false if inputLength > cardLength

          # Format the input value
          caret = e.target.selectionStart
          value = @_format value, input, card, caret

          # Calculate new caret position
          caret = caret + (value.length - e.target.value.length)
          
          # Assign formatted value
          e.target.value  = value

          # Set new caret position
          @_helper.setCaretPosition e.target, caret

          if @_helper.dirty(e.target) is "true"
            response.result e, field, (@validate(e.target.value))

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

    input = (input + '').replace(/\s/g, '')

    # Allow: only digit character [0-9]
    return false if !@_validates.isDigit input

    card        = @_validateCardPattern("#{value}#{input}") || @cardUnknow
    cardLength  = card.length

    inputLength = (value.replace(/\D/g, '') + input).length

    # Allow: character limit
    return false if inputLength > cardLength

    if card.type is 'unknow'
      @_hide e.target
    else
      @_show e.target, card

    # Format the input value
    caret = e.target.selectionStart
    value = @_format value, input, card, caret

    # Calculate new caret position
    caret = caret + (value.length - e.target.value.length)

    # Assign formatted value
    e.target.value  = value

    # Set new caret position
    @_helper.setCaretPosition e.target, caret

    if @_helper.dirty(e.target) is "true"
      response.result e, field, (@validate(e.target.value))

    e.preventDefault()

# Export class
window.OmiseValidation.ccnumber = OmiseCcNumberValidation
