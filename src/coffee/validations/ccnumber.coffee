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

    field.selector.onkeyup = (e) =>
      e       = e || window.event
      e.which = e.which || e.keyCode || 0
      @_onkeyupEvent e, field, response

    field.selector.onblur = (e) =>
      e       = e || window.event
      e.which = e.which || e.keyCode || 0
      @_onblurEvent e, field, response

    field.selector.onpaste = (e) =>
      e       = e || window.event
      e.which = e.which || e.keyCode || 0
      @_onpasteEvent e, field, response

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
  # Validate input card pattern
  # @param {string} num   - An input card number
  # @return {array}
  ###
  _validateCardPattern: (num) ->
    num = (num + '').replace(/\D/g, '')

    return _card for _card in @cards when _card.pattern.test(num) is true

  ###
  # Validate input card pattern
  # @param {string} num   - An input card number
  # @return {string} formatted value
  ###
  _reFormatCardPattern: (value = "", card) ->
    return value if value.length is 0

    value  = value.match /\d/g
    value  = value?.join "" || ""

    v = ""
    p = 0

    for char, i in card.format
      if char is "#"
        if p < value.length
          v += value[p]
          p += 1
        else
          break
      else
        v += char

    return v

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
  # Prevent the field from a word that will be invalid
  # @param {string} input - a value that retrieve from typing
  # @param {string} value - a current field's value
  # @param {object} e - an key event object
  # @return {boolean}
  ###
  _preventInput: (input, value, e) ->
    input = (input + '').replace(/\s/g, '')

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
    if (@_helper.isMetaKey(e)) is false
      # Allow: caps-lock, delete, tab, escape, home, end,
      # left-right, up-down arrows
      return true if e.which in [null, 0, 9, 13, 20, 27, 37, 38, 39, 40]

      # If press 'backspace'
      if e.which is 8
        if (range = @_helper.caretRange(e.target)) isnt ""
          pos = e.target.selectionStart

          p1 = e.target.value.slice(0, pos)
          p2 = e.target.value.slice(pos+range.length)
          
          _value = p1 + p2
          e.target.value = _value

        else if (pos = @_helper.getCaretPosition(e.target)) != 0
          if /\s/.test e.target.value[pos-1]
            pos = @_helper.delValFromCaretPosition e.target, 2
          else
            pos = @_helper.delValFromCaretPosition e.target

        card  = @_validateCardPattern(e.target.value) || @cardUnknow
        if card.type is 'unknow'
          @_hide e.target
        else
          @_show e.target, card

        e.preventDefault()

        # Set formatted value
        e.target.value = @_reFormatCardPattern e.target.value, card

        # Set new caret position
        @_helper.setCaretPosition e.target, pos

      # If press any keys
      else
        input = @_helper.inputChar e
        value = e.target.value

        return false unless @_preventInput input, value, e

        # Allow: if field have string in caret range
        if (range = @_helper.caretRange(e.target)) isnt ""
          if range.length is value.length
            return true

        # Format the input value
        c = e.target.selectionStart
        v = @_helper.insertValAfterCaretPos value, input, c
        v = (v + '').replace(/\D/g, '')

        card = @_validateCardPattern(v) || @cardUnknow

        if card.type is 'unknow'
          @_hide e.target
        else
          @_show e.target, card
        
        return false if v.length > card.length

        # Format the input value
        v = @_reFormatCardPattern v, card

        # Assign formatted value
        e.preventDefault()

        e.target.value  = v

        # Set new caret position
        c += 1

        if (v.charAt(c)) is ' '
          c += 1
        else if (v.charAt(c-1)) is ' '
          c += 1
          
        @_helper.setCaretPosition e.target, c

      # Validate a field if it dirty
      if @_helper.dirty e.target
        response.result e, field, (@validate(e.target.value))

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

    return false unless @_preventInput input, value, e

    # Format the input value
    range = @_helper.getCaretRange e.target
    if (range.start is range.end)
      c = e.target.selectionStart
      v = @_helper.insertValAfterCaretPos value, input, c
      v = (v + '').replace(/\D/g, '')
    else
      c = e.target.selectionStart

      if (range.start is 0 and range.end is value.length)
        c = range.start
        v = input
        value = ''
      else
        p1 = e.target.value.slice(0, range.start)
        p2 = e.target.value.slice(range.end)
        v = p1 + input + p2
        value = p1 + p2
      
    v     = (v + '').replace(/\D/g, '')
    card  = @_validateCardPattern(v) || @cardUnknow

    if card.type is 'unknow'
      @_hide e.target
    else
      @_show e.target, card
    
    # Allow: if field have string in caret range
    # if (range = @_helper.caretRange(e.target)) is ""
    return false if v.length > card.length

    # Format the input value
    v = @_reFormatCardPattern v, card
    
    newC = (Math.abs(v.length - value.length))
    c = c + (Math.abs(v.length - value.length))
    if / $/.test value
      c += 1

    # Assign formatted value
    e.preventDefault()

    e.target.value  = v

    @_helper.setCaretPosition e.target, c

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
window.OmiseValidation.ccnumber = OmiseCcNumberValidation
