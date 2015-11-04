class OmiseValidator
  constructor: ->
    @core = new window.OmiseValidation.validation

    @rules =
      ccName          : new window.OmiseValidation.ccname
      ccNumber        : new window.OmiseValidation.ccnumber
      ccExpiry        : new window.OmiseValidation.ccexpiry
      ccExpiryMonth   : new window.OmiseValidation.ccexpirymonth
      ccExpiryYear    : new window.OmiseValidation.ccexpiryyear
      ccSecurityCode  : new window.OmiseValidation.ccsecuritycode

    # Initiate variables
    @form =
      form            : null
      fields          : []

  ###
  # Set a validation to an element
  # @callback failureCallback
  # @param {object} form - the form object
  # @param {object} form.form - a selector of the form target element
  # @param {object} form.fields - a field objects
  # @see more the property list of form.fields in '@validates' method
  #
  # @param {string} field - the name of an element that have to validate
  # @param {string} rule - the name of a validation
  # @param {failureCallback} [default=null] callback - the callback function
  # @return {void}
  ###
  validates: (field, rule, callback = null) ->
    if typeof field is "string" and typeof rule is "string"
      @form.fields.push
        target    : field
        validates : if typeof rule is "string" then [rule] else rule
        selector  : null
        callback  : callback

  ###
  # Verbose way of the 'CcName' validation
  # @callback failureCallback
  # @param {object} form - the form object
  # @param {object} form.form - a selector of the form target element
  # @param {object} form.fields - a field objects
  # @see more the property list of form.fields in '@validates' method
  #
  # @param {string} field - the name of an element that have to validate
  # @param {failureCallback} [default=null] callback - the callback function
  # @return {void}
  ###
  validateCcName: (field, callback = null) ->
    @validates field, 'ccName', callback

  ###
  # Verbose way of the 'validateCcNumber' validation
  # @callback failureCallback
  # @param {object} form - the form object
  # @param {object} form.form - a selector of the form target element
  # @param {object} form.fields - a field objects
  # @see more the property list of form.fields in '@validates' method
  #
  # @param {string} field - the name of an element that have to validate
  # @param {failureCallback} [default=null] callback - the callback function
  # @return {void}
  ###
  validateCcNumber: (field, callback = null) ->
    @validates field, 'ccNumber', callback

  ###
  # Verbose way of the 'validateCcExpiry' validation
  # @callback failureCallback
  # @param {object} form - the form object
  # @param {object} form.form - a selector of the form target element
  # @param {object} form.fields - a field objects
  # @see more the property list of form.fields in '@validates' method
  #
  # @param {string} field - the name of an element that have to validate
  # @param {failureCallback} [default=null] callback - the callback function
  # @return {void}
  ###
  validateCcExpiry: (field, callback = null) ->
    @validates field, 'ccExpiry', callback

  ###
  # Verbose way of the 'validateCcExpiryMonth' validation
  # @callback failureCallback
  # @param {object} form - the form object
  # @param {object} form.form - a selector of the form target element
  # @param {object} form.fields - a field objects
  # @see more the property list of form.fields in '@validates' method
  #
  # @param {string} field - the name of an element that have to validate
  # @param {failureCallback} [default=null] callback - the callback function
  # @return {void}
  ###
  validateCcExpiryMonth: (field, callback = null) ->
    @validates field, 'ccExpiryMonth', callback

  ###
  # Verbose way of the 'validateCcExpiryYear' validation
  # @callback failureCallback
  # @param {object} form - the form object
  # @param {object} form.form - a selector of the form target element
  # @param {object} form.fields - a field objects
  # @see more the property list of form.fields in '@validates' method
  #
  # @param {string} field - the name of an element that have to validate
  # @param {failureCallback} [default=null] callback - the callback function
  # @return {void}
  ###
  validateCcExpiryYear: (field, callback = null) ->
    @validates field, 'ccExpiryYear', callback

  ###
  # Verbose way of the 'validateCcSecurityCode' validation
  # @callback failureCallback
  # @param {object} form - the form object
  # @param {object} form.form - a selector of the form target element
  # @param {object} form.fields - a field objects
  # @see more the property list of form.fields in '@validates' method
  #
  # @param {string} field - the name of an element that have to validate
  # @param {failureCallback} [default=null] callback - the callback function
  # @return {void}
  ###
  validateCcSecurityCode: (field, callback = null) ->
    @validates field, 'ccSecurityCode', callback

  ###
  # Attach all of a validation to a selector
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
  # @param {string} form - the name of a form element
  # @param {failureCallback} fc - will be executed when the form is invalid
  # @param {successCallback} sc - will be executed when the form is valid
  # @return {void}
  ###
  attachForm: (form = null, fc = null, sc = null) ->
    if form?
      # Retrieve a selector
      @form.form = @_manipulateSelectors form
      return false unless @form.form?

      # Initiate and attach validation event to a field
      for field, i in @form.fields.reverse() by -1
        continue if field.selector?

        result = do (field) =>
          # Retrieve a selector
          field.selector = @_manipulateSelectors field.target
          return false unless field.selector?

          # Retrieve a validation class
          field.validates = @rules[field.validates[0]] or false
          return false unless field.validates isnt false

          # Transform a target field to be a validate field
          @_initValidateField field.selector, field.target

          # Observe/Listen to target field
          @_observeField field

        if result is false
          @form.fields.splice i, 1
        else
          @form.fields[i] = field

      # Listen to submit event
      @_observeForm @form, fc, sc
      return

  ###
  # Manipulate a selector from element's id or class attribute
  # @param {string} target - the name of an element
  # @return {object} a HTML DOM object
  ###
  _manipulateSelectors: (target) ->
    return switch target[0]
      when "#" then document.getElementById target.substring(1)
      when "." then (document.getElementsByClassName target.substring(1))[0]
      else document.getElementById(target)

  ###
  # Transform a target field to be a validated field
  # @param {object} elem - an element that is a target
  # @param {string} prefix - The name that will be a prefix of an element's id
  # @return {void}
  ###
  _initValidateField: (elem, prefix) ->
    if /^[.#]/.test prefix
      prefix = prefix.substring(1)

    # Check duplicate element
    cnt = document.getElementsByClassName "#{prefix}_wrapper"
    cnt = if cnt.length > 0 then cnt.length else ""

    # Create wrapper element
    wrapper                     = document.createElement 'span'
    wrapper.id                  = "#{prefix}#{cnt}_wrapper"
    wrapper.className           = "omise_validation_wrapper"

    elem.parentNode.replaceChild wrapper, elem
    wrapper.appendChild elem

    # Create validate message element
    message                     = document.createElement 'span'
    message.id                  = "#{prefix}#{cnt}_validation_msg"
    message.className           = "omise_validation_msg"
    wrapper.appendChild message

    # Set data attributes
    elem.dataset.dirty          = false
    elem.dataset.wrapper        = wrapper.id
    elem.dataset.validationMsg  = message.id

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
  _observeForm: (form, fc = null, sc = null) ->
    @core.observeForm form, fc, sc

  ###
  # Listen to field event
  # @param {object} field - the field that be retrieved from @form variable
  # @param {string} field.target - a field name (might be a id or class name)
  # @param {object} field.validates - a validation class
  # @param {object} field.selector - a selector of a target field
  # @param {object} field.callback - a callback function
  # @return {void}
  ###
  _observeField: (field) ->
    @core.observeField field

# Export class
window.OmiseValidation  = {}
window.OmiseValidator   = OmiseValidator
