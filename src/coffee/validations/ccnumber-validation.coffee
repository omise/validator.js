class OmiseCcNumberValidation
  constructor: ->
    # List of card that be accepted
    @cardAcceptance   = [
        type          : 'mastercard'
        pattern       : /^5[1-5]/
        format        : /(\d{14})/g
        length        : [16]
        cvcLength     : [3]
      ,
        type          : 'visa'
        pattern       : /^4/
        format        : /(\d{14})/g
        length        : [13..16]
        cvcLength     : [3]
    ]

    @cardIcons        =
      visa            : null 
      mastercard      : null 

  ###
  # Initiate card number field
  # @param {object} elem - selector object of an element
  # @return {void}
  ###
  init: (elem) ->
    @_appendCcIcon elem

    # Attach an event
    elem.onkeypress = (e) =>
      e = e || window.event

      # Allow: backspace, delete, tab, escape, home, end and left-right arrow
      return true if e.which in [null, 0, 9, 27]

      # Detect 'backspace' key
      if e.which is 8
        pointer = e.target.selectionStart - 1
        if pointer >= 0
          card = @_validateCardPattern (e.target.value.slice(0, pointer) + e.target.value.slice(pointer+1))
        else
          card = @_validateCardPattern(e.target.value)
      else
        inp = String.fromCharCode e.which

        # Allow: only degit character [0 - 9]
        return false if !/^\d+$/.test inp
          
        card          = @_validateCardPattern(e.target.value + inp)
        cardLength    = if card then card.length[card.length.length - 1] else 16

        inputLength   = (e.target.value.replace(/\D/g, '') + inp).length

        return false if inputLength > cardLength
        return false if e.target.selectionStart? && e.target.selectionStart isnt e.target.value.length

        inputPattern  = /(?:^|\s)(\d{4})$/

        if inputPattern.test e.target.value
          e.preventDefault();
          e.target.value = e.target.value + ' ' + inp
        else if inputPattern.test e.target.value + inp
          e.preventDefault();
          e.target.value = e.target.value + inp + ' '

      
      if card then @_show card else @_hide()

  ###
  # Create parent element of 'omise_card_number' element.
  # The reason is for append credit card icons and show it inside input field.
  # @param {object} elem - selector object of an element
  # @return {void}
  ###
  _appendCcIcon: (elem) ->
    _parent                   = elem.parentNode
    _wrapper                  = document.createElement 'span'
    _wrapper.id               = "omise_card_number_wrapper"
    _wrapper.style.position   = "relative"

    # Create visa icon element
    _ccVisa                   = document.createElement 'img'
    _ccVisa.src               = '../../assets/images/icon-visa.png'
    _ccVisa.className         = 'omise_card_number_card omise_card_number_card_visa'

    # Create mastercard icon element
    _ccMastercard             = document.createElement 'img'
    _ccMastercard.src         = '../../assets/images/icon-mastercard.png'
    _ccMastercard.className   = 'omise_card_number_card omise_card_number_card_mastercard'

    _parent.replaceChild _wrapper, elem
    
    _wrapper.appendChild elem
    _wrapper.appendChild _ccVisa
    _wrapper.appendChild _ccMastercard

    @cardIcons.visa        = _ccVisa
    @cardIcons.mastercard  = _ccMastercard

  ###
  # Show a valid credit card logo
  # @param {object} card - one of cardAcceptance object
  # @return {void}
  ###
  _show: (card) ->
    @_hide()
    className = @cardIcons[card.type].className
    if className.search('valid') < 0
      @cardIcons[card.type].className = className + " valid"

  ###
  # Hide all of credit card logos
  # @return {void}
  ###
  _hide: ->
    for key, card of @cardIcons
      @cardIcons[key].className = @cardIcons[key].className.replace /valid/gi, ""

  ###
  # Validate input card pattern
  # @param {string} num   - An input card number
  # @return {array}
  ###
  _validateCardPattern: (num) ->
    num = (num + '').replace(/\D/g, '')

    return _card for _card in @cardAcceptance when _card.pattern.test(num) is true


# Export class
window.OmiseValidation.ccnumber = OmiseCcNumberValidation
