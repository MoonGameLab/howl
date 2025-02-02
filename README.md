# The Howl editor <Custom For **personal** Use>

## What is it?

Howl is a general purpose editor that aims to be both lightweight
and fully customizable. It's built on top of the very fast
[LuaJIT](http://luajit.org) runtime, uses [Gtk](http://www.gtk.org) for its
interface, and can be extended in either [Lua](http://www.lua.org) or
[Moonscript](http://www.moonscript.org). It's known to work on Linux, but
should work on at least the \*BSD's as well.

**This fork is intended for personal use.**

It is released as free software under the [MIT](http://opensource.org/licenses/MIT)
See original repo here : [Github](https://github.com/howl-editor/howl).

### Build requirements

- `wget`: For auto-downloading build dependencies.
- `GTK+`: Version >= 3, with development files (e.g. `libgtk-3-dev` on Debian
based system).
- `C compiler`: Howl has a very small C core itself, and it embeds
dependencies written in C.
- `pkg-config`: Helper tool to find libraries on the system.

### Build && install

Clone the repository or download and unpack a release. Cd into the `src`
directory, and run `make && sudo make install`. The installed binary will be
named `howl`.

## Cheat Sheet

|                              | **Action**        | **Command**                    |
| ---------------------------- | ----------------- | ------------------------------ |
| **Cursor Movement**          | left              | 'cursor-left'                  |
|                              | right             | 'cursor-right'                 |
|                              | up                | 'cursor-up'                    |
|                              | down              | 'cursor-down'                  |
|                              | shift_left        | 'cursor-left-extend'           |
|                              | shift_right       | 'cursor-right-extend'          |
|                              | shift_up          | 'cursor-up-extend'             |
|                              | shift_down        | 'cursor-down-extend'           |
|                              | alt_up            | 'editor-move-lines-up'         |
|                              | alt_down          | 'editor-move-lines-down'       |
|                              | alt_left          | 'editor-move-text-left'        |
|                              | alt_right         | 'editor-move-text-right'       |
|                              | page_up           | 'cursor-page-up'               |
|                              | shift_page_up     | 'cursor-page-up-extend'        |
|                              | page_down         | 'cursor-page-down'             |
|                              | shift_page_down   | 'cursor-page-down-extend'      |
|                              | end               | 'cursor-line-end'              |
|                              | shift_end         | 'cursor-line-end-extend'       |
|                              | home              | 'cursor-home'                  |
|                              | shift_home        | 'cursor-home-extend'           |
|                              | ctrl_home         | 'cursor-start'                 |
|                              | ctrl_shift_home   | 'cursor-start-extend'          |
|                              | ctrl_end          | 'cursor-eof'                   |
|                              | ctrl_shift_end    | 'cursor-eof-extend'            |
|                              | ctrl_left         | 'cursor-word-left'             |
|                              | ctrl_right        | 'cursor-word-right-end'        |
|                              | ctrl_up           | 'editor-scroll-up'             |
|                              | ctrl_down         | 'editor-scroll-down'           |
|                              | ctrl_shift_left   | 'cursor-word-left-extend'      |
|                              | ctrl_shift_right  | 'cursor-word-right-end-extend' |
|                              | ctrl_shift_up     | 'editor-scroll-up'             |
|                              | ctrl_shift_down   | 'editor-scroll-down'           |
| **Text Editing**             | tab               | 'editor-smart-tab'             |
|                              | shift_tab         | 'editor-smart-back-tab'        |
|                              | backspace         | 'editor-delete-back'           |
|                              | shift_backspace   | 'editor-delete-back'           |
|                              | ctrl_backspace    | 'editor-delete-back-word'      |
|                              | delete            | 'editor-delete-forward'        |
|                              | ctrl_delete       | 'editor-delete-forward-word'   |
|                              | return            | 'editor-newline'               |
|                              | ctrl_return       | 'editor-newline-below'         |
|                              | ctrl_shift_return | 'editor-newline-above'         |
|                              | ctrl_k            | 'editor-delete-to-end-of-line' |
|                              | ctrl_shift_k      | 'editor-delete-line'           |
|                              | ctrl_i            | 'editor-indent'                |
|                              | ctrl_shift_i      | 'editor-indent-all'            |
|                              | ctrl_h            | 'buffer-replace'               |
|                              | ctrl_s            | 'save'                         |
|                              | ctrl_shift_s      | 'save-as'                      |
|                              | ctrl_v            | 'editor-paste'                 |
|                              | ctrl_shift_v      | 'editor-paste..'               |
|                              | ctrl_x            | 'editor-cut'                   |
|                              | ctrl_z            | 'editor-undo'                  |
|                              | ctrl_y            | 'editor-redo'                  |
|                              | ctrl_slash        | 'editor-toggle-comment'        |
|                              | ctrl_space        | 'editor-complete'              |
|                              | ctrl_tab          | 'view-next'                    |
|                              | shift_delete      | 'editor-cut'                   |
|                              | shift_insert      | 'editor-paste'                 |
|                              | ctrl_insert       | 'editor-copy'                  |
|                              | ctrl_a            | 'editor-select-all'            |
| **Buffer & File Management** | ctrl_b            | 'switch-buffer'                |
|                              | ctrl_c            | 'editor-copy'                  |
|                              | ctrl_d            | 'editor-duplicate-current'     |
|                              | ctrl_f            | 'buffer-search-forward'        |
|                              | ctrl_r            | 'buffer-search-backward'       |
|                              | ctrl_comma        | 'buffer-search-word-backward'  |
|                              | ctrl_period       | 'buffer-search-word-forward'   |
|                              | ctrl_g            | 'buffer-grep'                  |
|                              | ctrl_w            | 'buffer-close'                 |
|                              | ctrl_n            | 'new-buffer'                   |
|                              | alt_s             | 'buffer-structure'             |
|                              | alt_q             | 'editor-reflow-paragraph'      |
| **Project Management**       | ctrl_o            | 'open'                         |
|                              | ctrl_shift_o      | 'open-recent'                  |
|                              | ctrl_p            | 'project-open'                 |
|                              | ctrl_shift_r      | 'exec'                         |
|                              | ctrl_alt_r        | 'project-exec'                 |
|                              | ctrl_shift_b      | 'project-build'                |
| **Window & View**            | ctrl_shift_w      | 'view-close'                   |
|                              | ctrl_-            | 'zoom-out'                     |
|                              | ctrl_+            | 'zoom-in'                      |
|                              | f11               | 'window-toggle-fullscreen'     |
|                              | alt_x             | 'run'                          |
|                              | alt_j             | 'open-journal'                 |
|                              | shift_alt_left    | 'view-left-or-create'          |
|                              | shift_alt_right   | 'view-right-or-create'         |
|                              | shift_alt_up      | 'view-up-or-create'            |
|                              | shift_alt_down    | 'view-down-or-create'          |
| **Navigation**               | ctrl_<            | 'navigate-back'                |
|                              | ctrl_>            | 'navigate-forward'             |
|                              | alt_<             | 'navigate-go-to'               |
|                              | alt_g             | 'cursor-goto-line'             |
| **Version Control**          | ctrl_shift_d      | 'vc-diff-file'                 |
|                              | ctrl_alt_d        | 'vc-diff'                      |

## License

This fork is released under the MIT license (see the LICENSE.md file for the full
details).
