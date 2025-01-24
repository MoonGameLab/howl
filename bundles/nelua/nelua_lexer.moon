-- 2025 Tourahi Amine
-- License: MIT (see LICENSE.md at the top-level directory of the distribution)

howl.util.lpeg_lexer ->
  c = capture
  ident = (alpha + '_')^1 * (alpha + digit + '_')^0
  ws = c 'whitespace', S(' \t\r\n')
  continuation_ws = c 'continue', S(' \t\r\n')
  combining_ws = c 'combiner', S(' \t\r\n')^1

  identifer = c 'identifer', ident

  type = c 'type', word {
    'boolean', 'integer', 'uinteger', 'number', 'byte', 'isize', 'int8', 'int16', 'int32', 'int64',
    'int128', 'usize', 'uint8', 'uint16', 'uint32', 'uint64', 'uint128', 'float32', 'float64', 'float128'
    'string', 'enum', 'record', 'union', 'pointer', 'void'
  }

  attribute_spec = sequence {
    c 'operator', '[['
    c 'special', scan_until ']]'
    c 'operator', ']]'
    ws^0
  }

  keyword = c 'keyword', word {
    -- lua keywords: https://www.lua.org/manual/5.4/manual.html#3.1
    'and', 'break', 'do', 'else', 'elseif', 'end',
    'false', 'for', 'function', 'goto', 'if', 'in',
    'local', 'nil', 'not', 'or', 'repeat', 'return',
    'then', 'true', 'until', 'while',
vb
    -- nelua keywords: https://github.com/edubart/nelua-lang/blob/af61898a8d90dc9736ab8f2e21e24a09a19b138d/docs/_includes/prismlangs.js#L61
    'switch', 'case', 'continue', 'fallthrough', 'global', 'defer',
  }

  classdef = any {
    equence {
      c('keyword', word { '@enum', '@union', '@record' })
      combining_ws,
      c('type_def', ident)
      continuation_ws^0
      any {
        P(-1),
        c('operator', '{')
      }
    }
  }

  unfinished = sequence {
    c('keyword', word { '@record', '@enum', '@union'}),
    combining_ws,
    P(-1)
  }

  operator = c 'operator', S'+-*/%=<>~&^|!(){}[];.,?:'

  comment = c 'comment', any {
    P'//' * scan_until eol,
    span '/*', '*/'
  }


  number = c 'number', any {
    char_constant,
    float,
    hexadecimal_float,
    hexadecimal,
    octal,
    R'19' * digit^0,
  }


  special = c 'special', word {
    '_G', '_ENV', '_VERSION', '__index', '__newindex', '__mode', '__call', '__metatable',
    '__tostring', '__len', '__gc', '__add', '__sub', '__mul', '__div', '__mod', '__pow',
    '__concat', '__unm', '__eq', '__lt', '__le', 'assert',
    'collectgarbage', 'dofile', 'error', 'getfenv', 'getmetatable', 'ipairs', 'load',
    'loadfile', 'loadstring', 'module', 'next', 'pairs', 'pcall', 'print', 'rawequal',
    'rawget', 'rawset', 'require', 'select', 'setfenv', 'setmetatable', 'tonumber',
    'tostring', 'type', 'unpack', 'xpcall', 'arg', 'self',
    'coroutine', 'resume', 'status', 'wrap', 'create', 'running',
    'debug', 'getupvalue', 'sethook', 'getmetatable', 'gethook', 'setmetatable', 'setlocal',
    'traceback', 'setfenv', 'getinfo', 'setupvalue', 'getlocal', 'getregistry', 'getfenv',
    'io', 'lines', 'write', 'close', 'flush', 'open', 'output', 'type', 'read', 'stderr',
    'stdin', 'input', 'stdout', 'popen', 'tmpfile',
    'math', 'log', 'max', 'acos', 'huge', 'ldexp', 'pi', 'cos', 'tanh', 'pow', 'deg', 'tan',
    'cosh', 'sinh', 'random', 'randomseed', 'frexp', 'ceil', 'floor', 'rad', 'abs', 'sqrt',
    'modf', 'asin', 'min', 'mod', 'fmod', 'log10', 'atan2', 'exp', 'sin', 'atan'
    'os', 'exit', 'setlocale', 'date', 'getenv', 'difftime', 'remove', 'time', 'clock', 'tmpname',
    'rename', 'execute', 'package', 'preload', 'loadlib', 'loaded', 'loaders', 'cpath', 'config', 'path', 'seeall',
    'string', 'sub', 'upper', 'len', 'gfind', 'rep', 'find', 'match', 'char', 'dump', 'gmatch',
    'reverse', 'byte', 'format', 'gsub', 'lower',
    'table', 'setn', 'insert', 'getn', 'foreachi', 'maxn', 'foreach', 'concat', 'sort', 'remove'
  }

  constant = c '<const>', word any('_', upper)^1 * any('_', upper, digit)^0

  P {
    'all'

    all: any {
      comment,
      string,
      unfinished,
      classdef,
      type,
      keyword,
      special,
      operator,
      number,
      constant,
      identifer,
    }
  }

