class OmiseCcExpiryMonthValidation
  constructor: ->
    @charMax    = 2

  ###
  # Initiate validation rule
  ###
  init: (elem) ->
    elem.onkeypress = (e) =>
      e = e || window.event
      @validate e

  ###
  #
  ###
  validate: (e) ->
    switch e.which
      # Allow: backspace, delete, tab, escape, home, end and left-right arrow
      when null, 0, 8, 9, 27 then return
      
      else
        _inp = String.fromCharCode e.which
      
        # Allow: only digit character [0 - 9]
        return false if !/^\d+$/.test _inp

        return false if e.target.value.length >= @charMax

        if e.target.value.length is 0 and /^[2-9]+$/.test _inp
          e.preventDefault()
          e.target.value = 0 + _inp


# Export class
window.OmiseValidation.ccexpirymonth = OmiseCcExpiryMonthValidation
