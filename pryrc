# pry-debug
if defined?(PryByebug)
  Pry.commands.alias_command 'c', 'continue'
  Pry.commands.alias_command 'f', 'finish'
  Pry.commands.alias_command 'n', 'next'
  Pry.commands.alias_command 's', 'step'
end

Pry.commands.alias_command 'q', 'quit'

Pry.commands.alias_command 'w', 'whereami'
Pry.commands.alias_command 'W', 'watch'

Pry.config.correct_indent = false
