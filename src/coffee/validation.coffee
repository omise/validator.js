class Validation
  constructor: ->
    # Include dependencies
    @rule     = new window.OmiseValidation.rules
    @helper   = new window.OmiseValidation.helper
    @message  = new window.OmiseValidation.messages
    @response = new window.OmiseValidation.response

  ###
  # Listen to form event
  # @callback failureCallback
  # @param {object} form - the form object
  # @param {object} form.form - a selector of the form target element
  # @param {object} form.fields - a field objects
  # @see more the property list of form.fields in '@validates' method
  #
  # @callback successCallback
  # @param {object} form - a form object
  # @param {object} form.form - a selector of the form target element
  # @param {object} form.fields - a field objects
  # @see more the property list of form.fields in '@validates' method
  #
  # @param {object} form - the form that be retrieved from @form variable
  # @param {object} form.form - a selector of form target element
  # @param {object} form.fields - a field objects
  # @param {failureCallback} fc - will be executed when the form is invalid
  # @param {successCallback} sc - will be executed when the form is valid
  # @return {void}
  ###
  observeForm: (form, fc = null, sc = null) ->
    form.form.addEventListener 'submit', (e) =>
      e.preventDefault()

      invalid = false
      for field in form.fields
        # Make it dirty
        field.selector.dataset.dirty = true

        if (result = field.validates.validate(field.selector.value)) isnt true
          invalid = true

        @response.result e, field, result

      if invalid is false
        if typeof sc is 'function'
          sc form
        else
          form.form.submit()

      else if typeof fc is 'function'
        fc form
    , false

  ###
  # Listen to field event
  # @param {object} field - the field that be retrieved from @form variable
  # @param {string} field.target - a field name (might be a id or class name)
  # @param {object} field.validates - a validation class
  # @param {object} field.selector - a selector of a target field
  # @param {object} field.callback - a callback function
  # @return {void}
  ###
  observeField: (field) ->
    field.validates.init? field, {
      '_validates'  : @rule
      '_helper'     : @helper
      '_message'    : @message
      '_response'   : @response
    }

    field.selector.onkeydown = (e) =>
      @_onkeydownEvent e, field

    field.selector.onkeypress = (e) =>
      @_onkeypressEvent e, field

    field.selector.onkeyup = (e) =>
      @_onkeyupEvent e, field
      
    field.selector.onpaste = (e) =>
      @_onpasteEvent e, field

    field.selector.onblur = (e) =>
      @_onblurEvent e, field

  ###
  # Capture and handle on-key-down event
  # @param {object} e - an key event object
  # @param {object} field - the field that be retrieved from @form variable
  # @param {string} field.target - a field name (might be a id or class name)
  # @param {object} field.validates - a validation class
  # @param {object} field.selector - a selector of a target field
  # @param {object} field.callback - a callback function
  # @return {boolean}
  ###
  _onkeydownEvent: (e, field) ->
    e       = e || window.event
    e.which = e.which || e.keyCode || 0

    field.validates.onkeydownEvent? e, field
  
  ###
  # Capture and handle on-key-press event
  # @param {object} e - an key event object
  # @param {object} field - the field that be retrieved from @form variable
  # @param {string} field.target - a field name (might be a id or class name)
  # @param {object} field.validates - a validation class
  # @param {object} field.selector - a selector of a target field
  # @param {object} field.callback - a callback function
  # @return {boolean}
  ###
  _onkeypressEvent: (e, field) ->
    e       = e || window.event
    e.which = e.which || e.keyCode || 0

    field.validates.onkeypressEvent? e, field

  ###
  # Capture and handle on-key-up event
  # @param {object} e - an key event object
  # @param {object} field - the field that be retrieved from @form variable
  # @param {string} field.target - a field name (might be a id or class name)
  # @param {object} field.validates - a validation class
  # @param {object} field.selector - a selector of a target field
  # @param {object} field.callback - a callback function
  # @return {boolean}
  ###
  _onkeyupEvent: (e, field) ->
    e       = e || window.event
    e.which = e.which || e.keyCode || 0
  
    field.validates.onkeyupEvent? e, field

  ###
  # Capture and handle on-paste event
  # @param {object} e - an key event object
  # @param {object} field - the field that be retrieved from @form variable
  # @param {string} field.target - a field name (might be a id or class name)
  # @param {object} field.validates - a validation class
  # @param {object} field.selector - a selector of a target field
  # @param {object} field.callback - a callback function
  # @return {boolean}
  ###
  _onpasteEvent: (e, field) ->
    e       = e || window.event
    e.which = e.which || e.keyCode || 0
    
    field.validates.onpasteEvent? e, field
  
  ###
  # Capture and handle on-blur event
  # @param {object} e - an key event object
  # @param {object} field - the field that be retrieved from @form variable
  # @param {string} field.target - a field name (might be a id or class name)
  # @param {object} field.validates - a validation class
  # @param {object} field.selector - a selector of a target field
  # @param {object} field.callback - a callback function
  # @return {boolean}
  ###
  _onblurEvent: (e, field) ->
    e       = e || window.event
    e.which = e.which || e.keyCode || 0
    
    field.validates.onblurEvent? e, field

# Export class
window.OmiseValidation.validation = Validation
