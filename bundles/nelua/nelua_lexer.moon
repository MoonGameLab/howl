-- 2025 Tourahi Amine
-- License: MIT (see LICENSE.md at the top-level directory of the distribution)

howl.util.lpeg_lexer ->
  c = capture

  ident = (alpha + '_')^1 * (alpha + digit + '_')^0
  identifer = c 'identifer', ident

  -- The order is important here
  -- https://nelua.io/overview/#comments
  comment = c 'comment', any {
    span '--[=[', ']=]', -- including ']=]' (https://howl.io/doc/spec/util/lpeg_lexer_spec.html)
    span '--[[', ']]',
    P'--' * scan_until eol
  }

  keyword = c 'keyword', word {
    -- lua keywords: https://www.lua.org/manual/5.4/manual.html#3.1
    'and', 'break', 'do', 'else', 'elseif', 'end',
    'false', 'for', 'function', 'goto', 'if', 'in',
    'local', 'nil', 'not', 'or', 'repeat', 'return',
    'then', 'true', 'until', 'while',

    -- nelua keywords: https://github.com/edubart/nelua-lang/blob/af61898a8d90dc9736ab8f2e21e24a09a19b138d/docs/_includes/prismlangs.js#L61
    'switch', 'case', 'continue', 'fallthrough', 'global', 'defer',
  }


  P {
    'all'

    all: any {
      keyword,
      comment,
      identifer
    }
  }

