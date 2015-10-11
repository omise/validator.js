class OmiseCcNameValidation
  ###
  #
  ###
  defaultRule: (e) ->
    switch e.which
      # Allow: backspace, delete, tab, escape, home, end,
      # left-right arrow and space-bar
      when null, 0, 8, 9, 27, 32 then return

      else
        _inp = String.fromCharCode e.which

        # Allow: only alphabet character [A-Za-z]
        return false if !/^[a-z]+$/gi.test _inp

# Export class
window.OmiseValidation.ccname = OmiseCcNameValidation
