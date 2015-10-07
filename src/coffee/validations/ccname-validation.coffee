class OmiseCcNameValidation
  ###
  # Initiate card name field
  ###
  init: (elem) ->
    # Attach an event
    elem.onkeypress = (e) =>
      e = e || window.event

      # Allow: backspace, delete, tab, escape, home, end, left-right arrow and space-bar
      return true if e.which in [null, 0, 8, 9, 27, 32]

      inp = String.fromCharCode e.which

      # Allow: only alphabet character [A-Za-z]
      return false if !/^[a-z]+$/gi.test inp

# Export class
window.OmiseValidation.ccname = OmiseCcNameValidation
