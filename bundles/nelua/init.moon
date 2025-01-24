mode_reg =
  name: 'nelua'
  aliases: { 'nelua' }
  extensions: { 'nelua' }
  create: -> bundle_load('nlua_mode')
  parent: 'curly_mode'

howl.mode.register mode_reg

unload = -> howl.mode.unregister 'nelua'

return {
  info:
    author: '2025 Torahi Amine',
    description: 'Nelua language support',
    license: 'MIT',
  :unload
}
