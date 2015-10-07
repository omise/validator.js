class OmiseCcSecureValidation
  constructor: ->
    @charMax = 4

  ###
  # Initiate card secure field
  ###
  init: (elem) ->
    # Attach an event
    elem.onkeypress = (e) =>
      e = e || window.event

      # Allow: backspace, delete, tab, escape, home, end and left-right arrow
      return true if e.which in [null, 0, 8, 9, 27]

      inp = String.fromCharCode e.which
      
      # Allow: only digit character [0 - 9]
      return false if !/^\d+$/.test inp

      return false if e.target.value.length >= @charMax

# Export class
window.OmiseValidation.ccsecure = OmiseCcSecureValidation
