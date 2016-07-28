local parse = {}

function parse.parse(file_str)
  local file = io.open(file_str, 'r')
  local code = file:read("*all")
  local lines = string.gmatch(code,'[^\n]+')
  local result = {}
    
  for line in lines do
    local wordscount = 0
    local words = {}
    for v in string.gmatch(line,'[^%s]+') do
      wordscount = wordscount + 1
      words[wordscount] = v
    end
        
    local startstate = words[1]
    local scanned = words[2]
    local function get_actions()
      local temp = {}
      for k = 3, wordscount-1, 1 do
        temp[k-2] = words[k]
      end
      return temp
    end
    local actions = get_actions()
    if actions == nil then actions = {} end
    local changeto = words[wordscount]
        
    if result[startstate] == nil then
      local m_conf = {['strategy'] = {}, ['changeto'] = {}};
  
      if string.lower(scanned) == 'any' then
        m_conf['strategy']['Any'] = actions
        m_conf['changeto']['Any'] = changeto
      elseif string.lower(scanned) == 'none' then
        m_conf['strategy']['None'] = actions
        m_conf['changeto']['None'] = changeto
      else
        m_conf['strategy'][scanned] = actions
        m_conf['changeto'][scanned] = changeto
      end
      result[words[1]] = m_conf
      
    else
      if string.lower(scanned) == 'any' then
        result[startstate]['strategy']['Any'] = actions
        result[startstate]['changeto']['Any'] = changeto
      elseif string.lower(scanned) == 'none' then
        result[startstate]['strategy']['None'] = actions
        result[startstate]['changeto']['None'] = changeto
      else
        result[startstate]['strategy'][scanned] = actions
        result[startstate]['changeto'][scanned] = changeto        
      end
    end
  end
  
  file:close()

  return result
end

return parse