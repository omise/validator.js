class OmiseCcNumberValidation
  constructor: ->
    @respMessage = new window.OmiseValidation.messages

    # List of card that be accepted
    @cards = [
        type      : 'mastercard'
        pattern   : /^5[1-5]/
        format    : 'xxxx-xxxx-xxxx-xxxx'
        length    : 16
        cvcLength : 3
        icon      : '../../assets/images/icon-mastercard.png' 
      ,
        type      : 'visa'
        pattern   : /^4/
        format    : 'xxxx-xxxx-xxxx-xxxx'
        length    : 16
        cvcLength : 3
        icon      : '../../assets/images/icon-visa.png' 
      ,
        type      : 'visa_old'
        pattern   : /^4/
        format    : 'xxxx-xxx-xxx-xxx'
        length    : 13
        cvcLength : 3
        icon      : '../../assets/images/icon-visa.png' 
    ]

    @default =
      strLimit: 16

    @cardIcons        =
      visa            : null
      mastercard      : null

  ###
  # Initiate a validation
  # @param {object} elem - a selector object of an element
  # @param {object} field - the field object (retrieve from @form variable)
  # @return {void}
  ###
  init: (elem, field) =>
    # Initiate credit card icon
    @_appendCcIcon elem

    elem.onkeypress = (e) =>
      e = e || window.event
      # @_onkeypressEvent e, e.which, String.fromCharCode e.which
      @_onkeypressEvent elem, field, e

  ###
  # Validation method
  # @param {string} value - an input value
  # @param {string} fieldValue - a current value
  # @return {void}
  ###
  validate: (value, fieldValue = null) ->
    # Don't be an empty
    return @respMessage.get('emptyString') if value.length <= 0

    # Allow: only digit character [0-9]
    return @respMessage.get('digitOnly') if !/^\d+$/.test(value)

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
  # Handler on-key-press event
  # @param {object} elem - a selector object of an element
  # @param {object} field - the field object (retrieve from @form variable)
  # @param {object} e - an key event object
  # @return {boolean}
  ###
  _onkeypressEvent: (elem, field, e) =>
    switch e.which
      # Allow: delete, tab, escape, home, end and left-right arrow
      when null, 0, 9, 27 then return true
      
      when 8
        # ...

      else
        value       = String.fromCharCode e.which
        fieldValue  = e.target.value

        

        if (validate = @validate(value, fieldValue)) isnt true
          console.log validate

          if typeof field.callback is 'function'
            e.preventDefault()
            field.callback()
          else
            console.log 'asd'
            return false
    
        # return 

  # ###
  # # Validate input card pattern
  # # @param {string} num   - An input card number
  # # @return {array}
  # ###
  # _validateCardPattern: (num) ->
  #   num = (num + '').replace(/\D/g, '')

  #   return _card for _card in @cards when _card.pattern.test(num) is true

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

# Export class
window.OmiseValidation.ccnumber = OmiseCcNumberValidation
