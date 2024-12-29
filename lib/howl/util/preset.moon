
import PropertyTable, SandboxedLoader from howl.util

load_preset = (file) ->
  chunk = loadfile(file)
  box = SandboxedLoader file.parent, 'preset', no_implicit_globals: true
  box chunk


return PropertyTable {

  register: (name, file) ->
    error 'name not specified for preset', 2 if not name
    error 'file not specified for preset', 2 if not file
    status, ret = pcall load_preset, file
    error "Error applying preset '#{name}: #{ret}'" if not status

    for module, presets in pairs ret
      howl.config.define_presets module, presets

  get: (name) ->

}
