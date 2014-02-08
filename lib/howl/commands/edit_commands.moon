-- Copyright 2012-2013 Nils Nordman <nino at nordman.org>
-- License: MIT (see LICENSE.md)

import Buffer, command, mode from howl
import BufferPopup from howl.ui

command.register
  name: 'search-forward',
  description: 'Starts an interactive forward search'
  inputs: { '*forward_search' }
  handler: -> _G.editor.searcher\commit!

command.register
  name: 'repeat-search',
  description: 'Repeats the last search'
  inputs: {}
  handler: -> _G.editor.searcher\next!

command.register
  name: 'replace',
  description: 'Replaces text (within selection or globally)'
  inputs: { 'replace' }
  handler: (values) ->
    { target, replacement } = values
    chunk = _G.editor.active_chunk
    chunk.text, count = chunk.text\gsub target, replacement
    if count > 0
      log.info "Replaced #{count} occurrences of '#{target}' with '#{replacement}'"
    else
      log.warn "No occurrences of '#{target}' found"

command.register
  name: 'show-doc-at-cursor',
  description: 'Shows documentation for symbol at cursor, if available'
  handler: ->
    m = _G.editor.buffer.mode
    ctx = _G.editor.current_context
    if m.api and m.resolve_type
      node = m.api
      path, parts = m\resolve_type ctx

      if path
        node = node[k] for k in *parts when node

      node = node[ctx.word.text] if node

      if node and node.description
        buf = Buffer mode.by_name('markdown')
        buf.text = node.description
        _G.editor\show_popup BufferPopup buf
        return

    log.info "No documentation found for '#{ctx.word}'"

