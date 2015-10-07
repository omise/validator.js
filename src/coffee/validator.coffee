class OmiseValidator
  constructor: (@params = {}) ->
    # Initiate validation classes
    @ccNameValidation     = new window.OmiseValidation.ccname
    @ccNumberValidation   = new window.OmiseValidation.ccnumber
    @ccExpiryValidation   = new window.OmiseValidation.ccexpiry
    @ccSecureValidation   = new window.OmiseValidation.ccsecure

    delete window.OmiseValidation

    # Initiate variables
    @selectors    = {}
    @input        =
      name        : ""
      number      : ""
      expiry      : ""
      secure      : ""

    @_initFormSelectors()
    @_attachEvents()

  ###
  # Initiate default style sheet
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
  ###
  _initFormSelectors: (params = {}) ->
    @selectors    = 
      elemName    : document.getElementById 'omise_card_name'
      elemNumber  : document.getElementById 'omise_card_number'
      elemExpiry  : document.getElementById 'omise_card_expiration'
      elemSecure  : document.getElementById 'omise_card_security'

  ###
  # Attach envents to selectors
  ###
  _attachEvents: ->
    @ccNameValidation.init @selectors.elemName if @selectors.elemName?
    @ccNumberValidation.init @selectors.elemNumber if @selectors.elemNumber?
    @ccExpiryValidation.init @selectors.elemExpiry if @selectors.elemExpiry?
    @ccSecureValidation.init @selectors.elemSecure if @selectors.elemSecure?

window.OmiseValidation  = {}
window.OmiseValidator   = OmiseValidator
