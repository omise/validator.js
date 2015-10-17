class OmiseValidationHandler
  constructor: ->
    # Initiate validation classes
    @response = new window.OmiseValidation.response

    @rules =
      ccName          : new window.OmiseValidation.ccname
      ccNumber        : new window.OmiseValidation.ccnumber
      ccExpiry        : new window.OmiseValidation.ccexpiry
      ccExpiryMonth   : new window.OmiseValidation.ccexpirymonth
      ccExpiryYear    : new window.OmiseValidation.ccexpiryyear
      ccSecurityCode  : new window.OmiseValidation.ccsecuritycode

  ###
  # Get a validation class
  # @param {string} validation - the name of a validation
  # @return {object} a validation class
  ###
  getRule: (validation) ->
    return @rules[validation] or false

  ###
  # Set an observation to listen form event
  # @param {object} form - the form object (retrieve from @form variable)
  # @return {void}
  ###
  observeForm: (form) ->
    form.form.addEventListener 'submit', (e) =>
      e.preventDefault()

      for field, i in form.fields
        validate = field.validates.validate field.selector.value

        if validate isnt true
          if typeof field.callback is 'function'
            field.callback()
          else
            @response.invalid field.selector, validate
        else
          @response.valid field.selector
    , false

  ###
  # Set an observation to listen field event
  # @param {object} field - the field object (retrieve from @form variable)
  # @param {object} selector - the field's HTML DOM object
  # @param {object} validation - the validation class object
  # @return {void}
  ###
  observeField: (field, selector, validation) ->
    @response.createElementForPushMsg selector

    # @invalidHandler
    validation.init selector, field

# Export class
window.OmiseValidation.validation = OmiseValidationHandler