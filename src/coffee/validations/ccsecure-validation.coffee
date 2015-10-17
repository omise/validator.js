class OmiseCcSecurityCodeValidation
  constructor: ->
    @respMessage = new window.OmiseValidation.messages

    # Limitation of input length
    @strLimit = 4

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
  validate: (value, fieldValue = "") ->
    # Length limit
    return false if fieldValue.length >= @strLimit

    # Don't be an empty
    return @respMessage.get('emptyString') if value <= 0

    # Allow: only digit character [0-9]
    return @respMessage.get('digitOnly') if !/^\d+$/.test(value)

    return true

  ###
  # Handler on-key-press event
  # @param {object} e - an key event object
  # @return {boolean}
  ###
  _onkeypressEvent: (e, key, value) =>
    switch key
      # Allow: backspace, delete, tab, escape, home, end,
      # and left-right arrow
      when null, 0, 8, 9, 27 then return true

      else
        return @validate value, e.target.value

# Export class
window.OmiseValidation.ccsecuritycode = OmiseCcSecurityCodeValidation
