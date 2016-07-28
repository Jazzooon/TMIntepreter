local machine = {}

-- m-configurations is a collection of m-configuration
-- m-configuration has the following structures
-- { ['state'] = { ['strategy'] = { ['somesymbol'] = {actions}, 
--                                  ['Any'] = {actions},
--                                  ['None'] = {actions} }, 
--                 ['changeto'] = { ['someymbol'] = '',
--                                  ['Any'] = ''} }

local Machine = {m_confs = {}, start_state = '', index = 1, tape = {}}

function Machine:new(m_confs, start_state)
  setmetatable(self, Machine)
  
  self.m_confs = m_confs
  self.current_state = start_state
  self.m_conf = m_confs[start_state]
  self.index = 1
  self.tape = {}
  
  return self
end

function Machine:run()
  local currentsquare = self.tape[self.index]
  local nextstate
  local actions
  
  if currentsquare == nil then
    actions = self.m_conf['strategy']['None']
    nextstate = self.m_conf['changeto']['None']
  else
    if self.m_conf['strategy'][currentsquare] == nil then
      actions = self.m_conf['strategy']['Any']
      nextstate = self.m_conf['changeto']['Any']
    else
      actions = self.m_conf['strategy'][currentsquare]
      nextstate = self.m_conf['changeto'][currentsquare]
    end
  end
  
  for _, action in ipairs(actions) do
    self:execute(action)
  end
  
  self.current_state = nextstate
  self.m_conf = self.m_confs[self.current_state]
  return self
end

function Machine:print()
  for k = 1, self.index, 1 do
    val = self.tape[k]
    if val == nil then
      io.write(' _ ')
    else
      io.write(' ', val, ' ')
    end
  end
    
  return self
end

function Machine:execute(action)
  if action == 'R' then
    self.index = self.index + 1
  elseif action == 'L' then
    self.index = self.index - 1
  elseif action == 'E' then
    self.tape[self.index] = nil
  elseif string.sub(action, 1, 1) == 'P' then
    self.tape[self.index] = string.sub(action, 2)
  end

  return self
end

machine.Machine = Machine
return machine