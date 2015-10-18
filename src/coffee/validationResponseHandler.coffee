class OmiseValidationResponseHandler

  ###
  # Initiate element for push a message
  # below an element target
  # @param {DOM - object} elem - ...
  # @return {void}
  ###
  createElementForPushMsg: (elem) ->
    _wrapper          = document.getElementById elem.dataset.wrapper

    _idName           = elem.dataset.wrapper.replace(/_wrapper$/g, '')
    _idName           = "#{_idName}_validation_msg"

    _msg              = document.createElement 'span'
    _msg.id           = _idName
    _msg.className    = "omise_validation_msg"
    
    _wrapper.appendChild _msg
    elem.dataset.validationMsg = _idName

  ###
  #
  # @param {DOM - object} elem - ...
  # @param {string} msg - ...
  # @return {void}
  ###
  pushMessage: (elem, msg) ->
    _t = elem.dataset.validationMsg
    _t = document.getElementById _t
    
    _t?.innerHTML  = msg

  ###
  #
  # @param {DOM - object} elem - ...
  # @param {string} msg - ...
  # @return {void}
  ###
  invalid: (elem, msg) ->
    _w = document.getElementById elem.dataset.wrapper
    
    _w.className = _w.className.replace /\ valid/, ''

    if / invalid/.test(_w.className) is false
      _w.className += " invalid"

    @pushMessage elem, msg

  ###
  #
  # @param {DOM - object} elem - ...
  # @return {void}
  ###
  valid: (elem) ->
    _w = document.getElementById elem.dataset.wrapper
    
    _w.className = _w.className.replace /\ invalid/, ''

    if / valid/.test(_w.className) is false
      _w.className += " valid"
    
    @pushMessage elem, ''

  result: (field, result) ->
    if result isnt true
      if typeof field.callback is 'function'
        field.callback field, result
      else if result is false
        return false
      else
        @invalid field.selector, result
    else
      @valid field.selector

window.OmiseValidation.response = OmiseValidationResponseHandler
