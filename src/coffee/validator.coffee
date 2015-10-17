class OmiseValidator
  constructor: ->
    @validation = new window.OmiseValidation.validation

    # Initiate variables
    @form =
      form: null
      fields: []

  ###
  # Set a validation to an element
  # @param {string} field - the name of an element that have to validate
  # @param {string} rule - the name of a validation
  # @param {function} [default=null] callback - the callback function
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
  # @param {string} field - the name of an element that have to validate
  # @param {function} [default=null] callback - the callback function
  # @return {void}
  ###
  validateCcName: (field, callback) ->
    @validates field, 'ccName', callback

  ###
  # Verbose way of the 'validateCcNumber' validation
  # @param {string} field - the name of an element that have to validate
  # @param {function} [default=null] callback - the callback function
  # @return {void}
  ###
  validateCcNumber: (field, callback) ->
    @validates field, 'ccNumber', callback

  ###
  # Verbose way of the 'validateCcExpiry' validation
  # @param {string} field - the name of an element that have to validate
  # @param {function} [default=null] callback - the callback function
  # @return {void}
  ###
  validateCcExpiry: (field, callback) ->
    @validates field, 'ccExpiry', callback

  ###
  # Verbose way of the 'validateCcExpiryMonth' validation
  # @param {string} field - the name of an element that have to validate
  # @param {function} [default=null] callback - the callback function
  # @return {void}
  ###
  validateCcExpiryMonth: (field, callback) ->
    @validates field, 'ccExpiryMonth', callback

  ###
  # Verbose way of the 'validateCcExpiryYear' validation
  # @param {string} field - the name of an element that have to validate
  # @param {function} [default=null] callback - the callback function
  # @return {void}
  ###
  validateCcExpiryYear: (field, callback) ->
    @validates field, 'ccExpiryYear', callback

  ###
  # Verbose way of the 'validateCcSecurityCode' validation
  # @param {string} field - the name of an element that have to validate
  # @param {function} [default=null] callback - the callback function
  # @return {void}
  ###
  validateCcSecurityCode: (field, callback) ->
    @validates field, 'ccSecurityCode', callback

  ###
  # Attach all of an validation to a selector
  # @param {string} form - name of a form element
  # @return {void}
  ###
  attachForm: (form = null) ->
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
          field.validates = @validation.getRule field.validates[0]
          return false unless field.validates isnt false

          @_createWrapperElem field.selector, field.target

          @validation.observeField field, field.selector, field.validates

        if result is false
          @form.fields.splice i, 1
        else
          @form.fields[i] = field

      # Listen submit event
      @validation.observeForm @form
      return

  ###
  # Manipulate a selector from element's id or class attribute
  # @param {string} target - the name of an element
  # @return {object} a HTML DOM object
  ###
  _manipulateSelectors: (target = {}) ->
    return switch target[0]
      when "#" then document.getElementById target.substring(1)
      when "." then (document.getElementsByClassName target.substring(1))[0]
      else document.getElementById(target)

  ###
  # Manipulate a selector from element's id or class attribute
  # @param {object} elem - an element that is a target
  # @param {string} prefix - The name that will be a prefix of an element's id
  # @return {void}
  ###
  _createWrapperElem: (elem, prefix) ->
    if /^[.#]/.test prefix
      prefix = prefix.substring(1)

    # Check duplicate element
    cnt = document.getElementsByClassName "#{prefix}_wrapper"
    cnt = if cnt.length > 0 then cnt.length else ""

    wrapper           = document.createElement 'span'
    wrapper.id        = "#{prefix}#{cnt}_wrapper"
    wrapper.className = "omise_validation_wrapper"

    elem.parentNode.replaceChild wrapper, elem
    wrapper.appendChild elem

    elem.dataset.wrapper      = "#{prefix}#{cnt}_wrapper"

  ###
  # Initiate the default style sheet element
  # @return {void}
  ###
  _initDefaultStyleSheet: do ->
    e      = document.createElement 'link'
    e.rel  = 'stylesheet'
    e.href = '../../assets/styles/omise-validation.css'

    l = document.documentElement
    l = l.lastChild while l.childNodes.length and l.lastChild.nodeType is 1
    l.parentNode.appendChild e

# Export class
window.OmiseValidation  = {}
window.OmiseValidator   = OmiseValidator
