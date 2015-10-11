class OmiseValidator
  constructor: (@params = {}) ->
    # Initiate validation classes
    @validationRules = new window.OmiseValidation.rules

    # Initiate variables
    @fields       = []
    @selectors    = {}

  ###
  # Initiate default style sheet
  # @return {void}
  ###
  _initCcStyle: do ->
    _elem         = document.createElement 'link'
    _elem.rel     = 'stylesheet'
    _elem.href    = '../../assets/styles/omise-validation.css'

    _lastElem     = document.documentElement
    _lastElem     = _lastElem.lastChild while _lastElem.childNodes.length and _lastElem.lastChild.nodeType is 1
    
    _lastElem.parentNode.appendChild _elem

  ###
  # Initiate selectors
  # @param {object} field - an object of a field
  # @return {DOM - object}
  ###
  _initSelectors: (field = {}) ->
    return switch field.target[0]
      when "#" then document.getElementById field.target.substring(1)
      when "." then (document.getElementsByClassName field.target.substring(1))[0]
      else document.getElementById(field.target)

  ###
  # Add validation rules into a target element
  # @param {string} field - name of an element that you want to validate
  # @param {array} validates - name of an element that you want to validate
  # @return {void}
  ###
  validates: (field, rules) ->
    if typeof field is "string" and
      (rules instanceof Array or typeof rules is "string")
        @fields.push
          target    : field
          validates : if typeof rules is "string" then [rules] else rules
          selector  : null

  ###
  # Attach envents to selectors
  # @return {void}
  ###
  attach: ->
    for field, i in @fields.reverse() by -1
      continue if field.selector?

      result = do (field) =>
        _elem = @_initSelectors(field)
        return false unless _elem?

        _rule = @validationRules.getRule field.validates[0]
        return false unless _rule isnt false

        _elem.onkeypress = (e) ->
          e = e || window.event
          _rule e

        return {
          target    : field.target
          validates : _rule
          selector  : _elem
        }
      
      if result is false
        @fields.splice i, 1
      else
        @fields[i] = result

    return

# Export class
window.OmiseValidation  = {}
window.OmiseValidator   = OmiseValidator
