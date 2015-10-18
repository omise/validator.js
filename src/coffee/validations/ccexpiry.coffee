class OmiseCcExpiryValidation
  constructor: ->
    @respMessage = new window.OmiseValidation.messages

    # Limitation of input length
    @strLimit = 6

    # Field's display pattern (mm / YYYY)
    @pattern = 'xx---xxxx'

  ###
  # Initiate a validation
  # @param {object} elem - a selector object of an element
  # @param {object} field - the field object (retrieve from @form variable)
  # @return {void}
  ###
  init: (elem, field) =>
    elem.onkeypress = (e) =>
      e = e || window.event
      validate = @_onkeypressEvent e, e.which, String.fromCharCode e.which

      if validate isnt true
        if typeof field.callback is 'function'
          e.preventDefault()
          field.callback()
        else
          return false

  ###
  # Validation method
  # @param {string} value - an input value
  # @param {string} fieldValue - a current value
  # @return {void}
  ###
  validate: (value, fieldValue = null) ->
    # Don't be an empty
    return @respMessage.get('emptyString') if value.length <= 0

  ###
  # Handler on-key-press event
  # @param {object} e - an key event object
  # @return {boolean}
  ###
  _onkeypressEvent: (e, key, value) =>
    switch key
      # Allow: delete, tab, escape, home, end and left-right arrow
      when null, 0, 9, 27 then return true
      
      when 8
        # ...

      else
        return @validate value, e.target.value


    # return true
    
    # inp = String.fromCharCode e.which

    # # Allow: delete, tab, escape, home, end and left-right arrow
    # return true if e.which in [null, 0, 9, 27]

    # # Detect 'backspace' key
    # if e.which is 8

    # else
    #   inp = String.fromCharCode e.which

    #   # Allow: only digit character [0 - 9]
    #   return false if !/^\d+$/.test inp

    #   return false if (e.target.value.replace(/\D/g, '')).length >= @strLimit


    #   if e.target.value.length is 0 and /^[2-9]+$/.test inp
    #     e.preventDefault()
    #     e.target.value = 0 + inp + " / "
    #     @strPattern[0] = "0"
    #     @strPattern[1] = inp
    #   else if (e.target.value.replace(/\D/g, '') + inp).length is 2
    #     e.preventDefault()
    #     e.target.value = e.target.value + inp + " / "
    #   else
    #     @strPattern[e.target.selectionStart] = inp

# Export class
window.OmiseValidation.ccexpiry = OmiseCcExpiryValidation
