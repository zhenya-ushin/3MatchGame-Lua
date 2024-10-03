local model = require("model")
local Visual = require("visual")
local model_interface = require("model_interface")
 function main()
  local matrix = model_interface.init(10, 10)
    while (#model.check_matches(matrix) > 0) do
  matrix = model_interface.mix(matrix)  
    end
  
  collectgarbage("collect")
  io.write("\n")
  model_interface.dump(matrix)
  local should_exit = false
    while (should_exit == false) do
      io.write("Type in move direction. For example m 0 0 d \n")
      user_input = io.read()
        for i = 1, #user_input do
          local char = string.sub(user_input, i,i) 
            if char == 'c' or char == 'q' then 
              io.write("The game was closed\n")
              os.exit()
              should_exit = true
            end
          end
        matrix = model_interface.tick(matrix, user_input)
        collectgarbage("collect")
    end
  end
main()
