-- 2025 Tourahi Amine
-- License: MIT (see LICENSE.md at the top-level directory of the distribution)

howl.util.lpeg_lexer ->
  c = capture

  -- The order is important here
  -- https://nelua.io/overview/#comments
  comment = c 'comment', any {
    span '--[=[', ']=]', -- including ']=]' (https://howl.io/doc/spec/util/lpeg_lexer_spec.html)
    span '--[[', ']]',
    P'--' * scan_until eol
  }

  P {
    'all'

    all: any {
      comment
    }
  }

