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

  ###
  # Validate input card pattern
  # @param {string} num   - An input card number
  # @return {array}
  ###
  _validateCardPattern: (num) ->
    num = (num + '').replace(/\D/g, '')

    return _card for _card in @cardAcceptance when _card.pattern.test(num) is true

  ###
  #
  ###
  defaultRule: (e) =>
    switch e.which
      # Allow: backspace, delete, tab, escape, home, end and left-right arrow
      when null, 0, 9, 27 then return

      # Detect 'backspace' key
      when 8
        if (pointer = e.target.selectionStart - 1) >= 0
          _value = (e.target.value.slice(0, pointer) + e.target.value.slice(pointer+1))

        console.log _value

        # Remove space conditions
        if _value? and
          (/\s$/.test(_value) or /\s$/.test(e.target.value))
            e.preventDefault()
            e.target.value = e.target.value.slice(0, (_value.length - 1))
        
      # Detect others key
      else
        _inp = String.fromCharCode e.which

        # Allow: only degit character [0 - 9]
        return false if !/^\d+$/.test _inp
        
        card        = @_validateCardPattern (e.target.value + _inp)
        cardLength  = if card then card.length[card.length.length - 1] else 16

        inputLength = (e.target.value.replace(/\D/g, '') + _inp).length

        return false if inputLength > cardLength
        return false if e.target.selectionStart? && e.target.selectionStart isnt e.target.value.length

        inputPattern  = /(?:^|\s)(\d{4})$/
        if inputPattern.test e.target.value
          e.preventDefault()
          e.target.value = e.target.value + ' ' + _inp
        else if inputPattern.test e.target.value + _inp
          e.preventDefault()
          e.target.value = e.target.value + _inp + ' '

# Export class
window.OmiseValidation.ccnumber = OmiseCcNumberValidation
