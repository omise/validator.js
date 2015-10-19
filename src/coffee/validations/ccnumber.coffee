class OmiseCcNumberValidation
  constructor: ->
    @respMessage  = new window.OmiseValidation.messages
    @helper       = new window.OmiseValidation.helper

    # List of card that be accepted
    @cards = [
        type      : 'mastercard'
        pattern   : /^5[1-5]/
        format    : '#### #### #### ####'
        length    : 16
        icon      : '../../assets/images/icon-mastercard.png'
      ,
        type      : 'visa'
        pattern   : /^4/
        format    : '#### #### #### ####'
        length    : 16
        icon      : '../../assets/images/icon-visa.png'
      ,
        type      : 'visa_old'
        pattern   : /^4/
        format    : '#### ### ### ###'
        length    : 13
        icon      : '../../assets/images/icon-visa.png'
    ]

    @cardUnknow =
      type      : 'unknow'
      format    : '#### #### #### ####'
      length    : 16
      cvcLength : 3

  ###
  # Initiate a validation
  # @param {object} field - the field object (retrieve from @form variable)
  # @param {object} response - the response handler class
  # @return {void}
  ###
  init: (field, response) =>
    # Initiate credit card icon
    @_appendCcIcon field.selector

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

    return true

  ###
  # Create a credit card icon's element
  # @param {object} elem - a selector object of an element
  # @return {void}
  ###
  _appendCcIcon: (elem) ->
    parent                = elem.parentNode
    
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

        if (pos = @helper.getCaretPosition(e.target)) != 0
          beDeleted = e.target.value[pos-1]

          if /\s/.test beDeleted
            pos = @helper.deleteValueFromCaretPosition e.target, 2
          else
            pos = @helper.deleteValueFromCaretPosition e.target

          card  = @_validateCardPattern(e.target.value) || @cardUnknow
        
          # Set formatted value
          e.target.value = @_reFormat e.target.value, card

          # Set new caret position
          @helper.setCaretPosition e.target, pos

      else
        e.preventDefault()

        # Validate the field when it's dirty only
        input = String.fromCharCode e.which
        value = e.target.value

        # Allow: only digit character [0-9]
        return false if !/^\d+$/.test input

        card = @_validateCardPattern("#{value}#{input}") || @cardUnknow

        return false if (value.replace(/\D/g, '') + input).length > card.length

        # Format the input value
        caret           = e.target.selectionStart
        e.target.value  = @_format value, input, card, caret

        # Set new caret position
        @helper.setCaretPosition e.target, caret+1

        if @helper.dirty(e.target) is "true"
          response.result field, (@validate(e.target.value))

  

  # ###
  # # Show a valid credit card logo
  # # @param {object} card - one of cardAcceptance object
  # # @return {void}
  # ###
  # _show: (card) ->
  #   @_hide()
  #   className = @cardIcons[card.type].className
  #   if className.search('valid') < 0
  #     @cardIcons[card.type].className = className + " valid"

  # ###
  # # Hide all of credit card logos
  # # @return {void}
  # ###
  # _hide: ->
  #   for key, card of @cardIcons
  #     card.className  = card.className.replace /valid/gi, ""
  #     @cardIcons[key] = card
      
  # ###
  # #
  # ###
  # _formatting: (card, value, input) ->
  #   inputPattern  = /(?:^|\s)(\d{4})$/
  
  #   strLimit = card?.length || @default.strLimit

  #   if (value.replace(/\D/g, '') + input).length > strLimit
  #     return value

  #   else if inputPattern.test value
  #     return value + ' ' + input
    
  #   else if inputPattern.test value + input
  #     return value + input + ' '

  # ###
  # #
  # ###
  # _reFormatting: (e) ->
  #   targetValue     = e.target.value
  #   targetCaretPos  = e.target.selectionStart

  #   deletedChar     = targetValue[targetCaretPos-1]

  #   # Caculate new value after deleted
  #   if (pointer = targetCaretPos - 1) >= 0
  #     _value = (targetValue.slice(0, pointer) + targetValue.slice(pointer + 1))
  #   else
  #     _value = targetValue

  #   # Looking for card pattern
  #   card = @_validateCardPattern _value

  #   if card? then @_show card else @_hide()

  #   # Remove space conditions
  #   if /\s$/.test(deletedChar) and /\s$/.test(targetValue)
  #     return targetValue.slice(0, (_value.length - 1))

  #   # If caret position is not the last position. Then, re-formatting.
  #   else if targetValue.length != targetCaretPos
  #     return @_format card, _value

  #   # else
  #   #   return _value

  # _format: (card, input) ->
  #   input     = input.replace(/\s/g, '')
  #   _reformat = ""
  #   _r = 0
  #   for pos, i in card.format
  #     (_reformat += " " ; continue) if pos is "-"

  #     break if _r > input.length - 1

  #     _reformat += input[_r]
  #     _r++
    
  #   input = _reformat if _reformat isnt ""
  #   return input

  # ###
  # #
  # ###
  # validate: (e) =>
  #   switch e.which
  #     # Allow: delete, tab, escape, home, end and left-right arrow
  #     when null, 0, 9, 27 then return

  #     # Backspace key
  #     when 8
  #       result = @_reFormatting e
  #       (e.preventDefault() ; e.target.value = result) unless !result
        
  #     else
  #       _input = String.fromCharCode e.which

  #       # Allow only digit character [0 - 9]
  #       return false if !/^\d+$/.test _input

  #       _targetValue      = e.target.value
  #       _currentCaretPos  = e.target.selectionStart



  #       _inputLength      = (e.target.value.replace(/\D/g, '') + _input).length

        



  #       card        = @_validateCardPattern (_evalue + _inp)
  #       cardLength  = card?.length || @default.strLimit



  #       # result = @_ e
  #       # _inp = String.fromCharCode e.which

  #       # # Allow: only digit character [0 - 9]
  #       # return false if !/^\d+$/.test _inp

  #       # _evalue     = e.target.value
  #       # _caretPos   = e.target.selectionStart
                
  #       # card        = @_validateCardPattern (_evalue + _inp)
  #       # cardLength  = card?.length[card.length.length - 1] || 16
        
  #       # inputLength = (_evalue.replace(/\D/g, '') + _inp).length

  #       # return false if inputLength > cardLength
  #       # return false if _caretPos? && _caretPos isnt _evalue.length

  #       # if card then @_show card else @_hide()

  #       # result = @_formatting card, _evalue, _inp
  #       # (e.preventDefault() ; e.target.value = result) unless !result



                
        
        
  #       inputLength = (_evalue.replace(/\D/g, '') + _inp).length

  #       return false if inputLength > cardLength
  #       return false if _caretPos? && _caretPos isnt _evalue.length

  #       if card then @_show card else @_hide()

  #       result = @_formatting card, _evalue, _inp
  #       (e.preventDefault() ; e.target.value = result) unless !result

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

# Export class
window.OmiseValidation.ccnumber = OmiseCcNumberValidation
