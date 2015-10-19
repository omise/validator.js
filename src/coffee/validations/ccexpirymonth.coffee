class OmiseCcExpiryMonthValidation
  constructor: ->
    @respMessage  = new window.OmiseValidation.messages
    @helper       = new window.OmiseValidation.helper

    # Limitation of an input length
    @strLimit = 2

    # Field's format
    @format       = /^(0[1-9]|1[0-2])$/

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
  # @param {string} value - a value that coming from typing
  # @param {string} fieldValue - a current field's value
  # @return {string|boolean}
  ###
  validate: (value, fieldValue = "") ->
    # Don't be an empty
    return @respMessage.get('emptyString') if value.length <= 0

    # Must match with card's expiry pattern
    return @respMessage.get('expiryFormat') if !@format.test value

    return true

  ###
  # Prevent the field from a word that will be invalid
  # @param {string} input - a value that coming from typing
  # @param {string} value - a current field's value
  # @return {boolean}
  ###
  _preventCharacter: (input, value) ->
    # Length limit
    return false if (value + input).length > @strLimit

    # Allow: only digit character [0-9]
    return false if !/^\d+$/.test input

    return true

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

        if (@helper.getCaretPosition(e.target)) != 0
          @helper.deleteValueFromCaretPosition e.target

        # Validate the field when it's dirty only
        if (@helper.dirty(e.target)) is "true"
          response.result field, (@validate(e.target.value))

      else
        input = String.fromCharCode e.which
        value = e.target.value

        return false unless @_preventCharacter input, value

        if value.length is 0 and /^[2-9]+$/.test input
          e.preventDefault()
          value           = "0#{input}"
          e.target.value  = value
        else
          value = "#{value}#{input}"

        if @helper.dirty(e.target) is "true"
          response.result field, (@validate(value))

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
window.OmiseValidation.ccexpirymonth = OmiseCcExpiryMonthValidation
