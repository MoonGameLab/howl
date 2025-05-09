-- Copyright 2012-2015 The Howl Developers
-- License: MIT (see LICENSE.md at the top-level directory of the distribution)

{:MenuPopup, :style} = howl.ui
{:Completer} = howl
{:abs} = math

is_character = (event) ->
  event.text and event.text.ulen == 1 and event.text\umatch r'[\\pL_]'

class CompletionPopup extends MenuPopup

  new: (editor) =>
    error('Missing argument #1: editor', 3) if not editor
    @editor = editor
    super {}, @\_on_completed

  @property position: get: => @completer.start_pos
  @property empty: get: => #@items == 0

  complete: =>
    return if @showing
    @active = true
    @_init_completer!
    @_load_completions!

  close: =>
    @completer = nil
    super!
    @active = nil

  on_insert_at_cursor: (editor, args) =>
    return unless @completer
    unless is_character args
      @close!
      return

    @_load_completions!
    @_insert_pos = editor.cursor.pos

  on_delete_back: (editor, args) =>
    return unless @completer
    if args.at_pos < @completer.start_pos or editor.current_line != @completer.line
      @close!
      return

  on_pos_changed: (cursor) =>
    if abs(cursor.pos - @_insert_pos) > 1
      @close!

  _init_completer: =>
    @_insert_pos = @editor.cursor.pos
    @completer = Completer @editor.buffer, @_insert_pos
    comp_style = style.at_pos(@editor.buffer, @completer.start_pos) or 'default'
    @list.columns = { { style: comp_style } }

  _load_completions: =>
    @items, @highlight_matches_for = @completer\complete @editor.cursor.pos

    if #@items > 0
      @refresh!
      @resize!
    else
      @close!

  _on_completed: (item) =>
    @editor.cursor.pos = @completer\accept item, @editor.cursor.pos
    true

return CompletionPopup
