class OmiseValidationResponse
  ###
  # Initiate an element for push a validation message
  # below an element target
  # @param {object} elem - an element target
  # @return {void}
  ###
  createElementForPushMsg: (elem) ->
    _wrapper        = document.getElementById elem.dataset.wrapper

    _idName         = elem.dataset.wrapper.replace(/_wrapper$/g, '')
    _idName         = "#{_idName}_validation_msg"

    _msg            = document.createElement 'span'
    _msg.id         = _idName
    _msg.className  = "omise_validation_msg"
    
    _wrapper.appendChild _msg
    elem.dataset.validationMsg = _idName

  ###
  # Push a message to a validation message field
  # @param {object} elem - an target element
  # @param {string} msg - a message that want to publish
  # @return {void}
  ###
  pushMessage: (elem, msg) ->
    _t = elem.dataset.validationMsg
    _t = document.getElementById _t
    
    _t?.innerHTML  = msg

  ###
  # Take an action when field's validation is invalid
  # @param {object} elem - an element target
  # @param {string} msg - a message that want to publish
  # @return {void}
  ###
  invalid: (elem, msg) ->
    _w = document.getElementById elem.dataset.wrapper
    
    _w.className = _w.className.replace /\ valid/, ''

    if / invalid/.test(_w.className) is false
      _w.className += " invalid"

    @pushMessage elem, msg

  ###
  # Take an action when field's validation is valid
  # @param {object} elem - an element target
  # @return {void}
  ###
  valid: (elem) ->
    _w = document.getElementById elem.dataset.wrapper
    
    _w.className = _w.className.replace /\ invalid/, ''

    if / valid/.test(_w.className) is false
      _w.className += " valid"
    
    @pushMessage elem, ''

  ###
  # Get a result and display it into a screen
  # @param {object} e - an key event object
  # @param {object} field - a field target
  # @param {string} field.target - a field name (might be a id or class name)
  # @param {object} field.validates - a validation class
  # @param {object} field.selector - a selector of a target field
  # @param {object} field.callback - a callback function
  # @param {boolean|string} result - a result of a validate action
  # @return {void}
  ###
  result: (e, field, result) ->
    if result isnt true
      if typeof field.callback is 'function'
        field.callback e, field, result
      else if result is false
        return false
      else
        @invalid field.selector, result
    else
      @valid field.selector

# Export class
window.OmiseValidation.response = OmiseValidationResponse
