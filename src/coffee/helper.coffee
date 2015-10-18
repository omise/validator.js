class Helper
  ###
  # Slice field's value starting from caret position
  # @param {object} elem - a selector object of an element
  # @param {int} length - number of string's length that need to slice
  # @return {object} elem - a selector object of an element
  ###
  deleteValueFromCaretPosition: (elem, length = 1) ->
    if ((post = elem.selectionStart - length) >= 0)
      # Set a new value into element
      elem.value = elem.value.slice(0, post) + elem.value.slice(post + length)
      
      # Set a new position of caret
      elem.focus()
      elem.setSelectionRange post, post

    return elem

  ###
  # Get caret position
  # @param {object} elem - a selector object of an element
  # @return {void}
  ###
  getCaretPosition: (elem) ->
    return elem.selectionStart

window.OmiseValidation.helper = Helper