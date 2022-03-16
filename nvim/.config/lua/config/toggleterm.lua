local Terminal  = require('toggleterm.terminal').Terminal
local lazydocker = Terminal:new({ cmd = "lazydocker", hidden = true, direction = 'float'})

function _lazydocker_toggle()
  lazydocker:toggle()
end

