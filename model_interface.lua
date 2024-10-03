local model_interface = {}
local Visual = require("visual")
local game_model = require("model")

function model_interface.init(rows, cols) -- строки, столбцы

local fieldMatrix = {}

  for i = 1, rows do
  fieldMatrix[i] = {} 
  
    for j = 1, cols do
      fieldMatrix[i][j] = 0
      
    end
  end
  
  fieldMatrix = game_model.pull_matrix(fieldMatrix)
  return fieldMatrix
end

function model_interface.tick(matrix, user_input) --исходная матрица, пользовательский ввод
  local match = {}
   local xFrom = tonumber(string.sub(user_input, 3, 3)) + 1
    local yFrom = tonumber(string.sub(user_input, 5, 5)) + 1
  
    local moveTo = string.sub(user_input, 7, 7)
    
    matrix = model_interface.move(matrix,{xFrom,yFrom}, moveTo)
    
    match = game_model.check_matches(matrix)
 
 
  if (#match < 3) then 

    if (moveTo == 'r') then 
     if (yFrom == 10) then 
       matrix = model_interface.move(matrix, {xFrom, yFrom}, 'l')
     else 
       matrix = model_interface.move(matrix, {xFrom, yFrom}, 'r') 
      end
    elseif (moveTo == 'l') then
      if(yFrom > 1) then 
          matrix = model_interface.move(matrix, {xFrom, yFrom}, 'l')
      else 
        matrix = model_interface.move(matrix, {xFrom, yFrom}, 'r')
      end
    elseif (moveTo == 'u') then
      if (xFrom > 1) then 
        matrix = model_interface.move(matrix, {xFrom , yFrom}, 'u')
      else 
      matrix = model_interface.move(matrix, {xFrom , yFrom}, 'd')
      end
    elseif (moveTo == 'd') then
      if (xFrom < 10) then 
        matrix = model_interface.move(matrix, {xFrom , yFrom}, 'd')
      else 
        matrix = model_interface.move(matrix, {xFrom , yFrom}, 'u')
      end
    end
  else 
   for i = 1, #match do
     
    local tx =  (match[i])[1]
    local ty = (match[i])[2]
    
     matrix[tx][ty] = 0
     local x = tx
        while (x > 1) do
          matrix =  model_interface.move(matrix, {x , ty}, 'u')
          x = x - 1
       end
    end
  end
  match = {}
  --]]
  --]]
 matrix = game_model.pull_matrix(matrix)
 if game_model.can_triple == false then
  while (#game_model.check_matches(matrix) > 0) do
  matrix = model_interface.mix(matrix)  
  end
end
model_interface.dump(matrix)
collectgarbage("collect")
io.write("\n")
return matrix
end

-- сдвиг ячейки матрицы в направлении
function model_interface.move(matrix,from, to) --матрица, {x,y}, направление

  local x = tonumber(from[1])
  local y = tonumber(from[2])
  if (to == 'd') and (x < 10) then
    matrix[x][y], matrix[x+1][y] = matrix[x+1][y], matrix[x][y]
  elseif (to == 'r') and (y <= 9) then
    matrix[x][y], matrix[x][y+1] = matrix[x][y+1],matrix[x][y]
  elseif (to == 'l') and (y > 1) then
    matrix[x][y], matrix[x][y-1] = matrix[x][y-1], matrix[x][y]
  elseif (to == 'u') and (x > 1) then
    matrix[x][y], matrix[x-1][y] = matrix[x-1][y], matrix[x][y]
  end
return matrix
end

-- перемешивание поля
function model_interface.mix(matrix) -- матрица
  local move_count = 0
  local max_moves = 100
  
    while move_count < max_moves do
      local i = math.random(1, #matrix)
      local j = math.random(1, #matrix[i])
      local swap_direction = math.random(1,4)
      local new_i, new_j = i, j
        if swap_direction == 1 and i > 1 then
          new_i = i - 1
        elseif swap_direction == 2 and i < #matrix then
          new_i = i + 1
        elseif swap_direction == 3 and j > 1 then
          new_j = j - 1
        elseif swap_direction == 4 and j < #matrix[i] then
          new_j = j + 1
        end
      if new_i ~= i or new_j ~= j then
        matrix[i][j], matrix[new_i][new_j] = matrix[new_i][new_j], matrix[i][j]
          if game_model.can_triple(matrix)==true then
            move_count = move_count + 1
          end
      end
  end

  collectgarbage("collect")
  
  return matrix
end

function model_interface.dump(matrix) -- матрица
  Visual.print_matrix(matrix)
  
end

return model_interface