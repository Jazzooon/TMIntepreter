parse = require('parse')
machine = require('machine')

function run_script(file_str, start_state)
  local m_config = parse.parse(file_str)
  local machine = machine.Machine:new(m_config,start_state)

  while true do
    machine = machine:run()
    machine:print()
    print()
    print()
  end
end

run_script(arg[1], arg[2])