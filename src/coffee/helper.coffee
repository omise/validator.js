class Helper
  ###
  # Slice field's value starting from caret position
  # @param {object} elem - a selector object of an element
  # @param {int} length - number of string's length that need to slice
  # @return {void}
  ###
  delValFromCaretPosition: (elem, length = 1) ->
    if ((pos = elem.selectionStart - length) >= 0)
      # Set a new value into element
      elem.value = elem.value.slice(0, pos) + elem.value.slice(pos + length)
    else
      elem.value = ""
    
    # Set a new position of caret
    elem.focus()
    elem.setSelectionRange pos, pos

    return pos

  ###
  # Get caret position
  # @param {object} elem - a selector object of an element
  # @return {void}
  ###
  getCaretPosition: (elem) ->
    return elem.selectionStart

  setCaretPosition: (elem, pos) ->
    elem.focus()
    elem.setSelectionRange pos, pos

  beDirty: (elem) ->
    elem.dataset.dirty = true

  dirty: (elem) ->
    return elem.dataset.dirty

window.OmiseValidation.helper = Helper