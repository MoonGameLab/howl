-- 2025 Tourahi Amine
-- License: MIT (see LICENSE.md at the top-level directory of the distribution)
append = table.insert

next_relevant_line = (line) ->
  l = line.next
  while l and (l.is_blank or l\match('^%s*#'))
    l = l.next

  l

{
  lexer: bundle_load('nelua_lexer')

  auto_pairs: {
    '(': ')'
    '[': ']'
    '{': '}'
    '"': '"'
    "'": "'"
  }

  structure: (editor) =>
    lines = {}
    line = editor.buffer.lines[1]
    candidate = nil

    line_end = '(--.*|--\\[\\[.*\\]\\])?$'
    constructs = "(record|union|enum)"
    construct_decl_p = r("^\\s*@#{constructs}\\s+\\S+\\s*{#{line_end}")
    opening_construct_p = r("^\\s*@(#{constructs})\\s*{\\s*#{line_end}")
    fdecl_p = r("^(local\\s*)?function\\s+\\S+\\([^)]*\\s*(const\\s*)?\\S+(?:<[^>]+>)?\\s*(,\\s*(const\\s*)?\\S+(?:<[^>]+>)?)*\\)\\s*(\\:\\s*\\S+)?\\s*{\\s*#{line_end}")
    control_stmt_p = r('^\\s*(if|else|switch|for|while|do)\\b')
    continuation_p = r("([,)]\\s*(const\\s*)?\\S+(?:<[^>]+>)?\\s*(,\\s*(const\\s*)?\\S+(?:<[^>]+>)?)*)\\s*(\\:\\s*\\S+)?\\s*(\\n|\\s*#{line_end})?")
    closing_p = r("{\\s*#{line_end}")

    is_declaration = (l) ->
      (fdecl_p\test(l) and not control_stmt_p\test(l)) or
        construct_decl_p\test(l)

    is_opening_decl = (l) ->
      return true if opening_construct_p\test(l)
      return false if control_stmt_p\test(l)

    while line
      text = line.text

      -- first check for any ready structure lines
      if not candidate
        if is_declaration(text)
          append lines, line
          candidate = nil
        -- else check for possible candidates: started but not finished
        elseif is_opening_decl(text)
          candidate = line
      else
        -- if we have a candidate already, check for closure or continuation
        if closing_p\test(text)
          append lines, candidate
          candidate = nil
        elseif not continuation_p\test(text)
          candidate = nil

      line = next_relevant_line line

    lines







}
