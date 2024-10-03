local game_model = {}
function game_model.setRandomColor() 
  local letters = {"A", "B", "C", "D", "E", "F"}
  local randomIndex = math.random(#letters)
  return letters[randomIndex]
end


function game_model.pull_matrix(fieldMatrix) -- матрица

  for i = 1, #fieldMatrix do
  for j = 1, #fieldMatrix do
      if fieldMatrix[i][j] == 0 then
        fieldMatrix[i][j] = game_model.setRandomColor()
        end
  end
end
return fieldMatrix
  end

function game_model.check_matches(matrix) -- матрица
  
  local match_indices = {}
  
  for i = 1, 10 do
    local start_index = 1
    while start_index <= 8 do
      if matrix[i][start_index] == matrix[i][start_index + 1] and matrix[i][start_index] == matrix[i][start_index + 2] then
        local end_index = start_index + 2
        while end_index <= 10 and matrix[i][start_index] == matrix[i][end_index] do
          end_index = end_index + 1
        end
        for j = start_index, end_index - 1 do
          table.insert(match_indices, {i, j})
          end
          start_index = end_index
        else
          start_index = start_index + 1
        end
      end
    end
    for j = 1, 10 do 
      local start_index = 1
    while start_index <= 8 do
      if matrix[start_index][j] == matrix[start_index + 1][j] and
               matrix[start_index][j] == matrix[start_index + 2][j] then
                 local end_index = start_index + 2
                while end_index <= 10 and matrix[start_index][j] == matrix[end_index][j] do
                    end_index = end_index + 1
                end
                for i = start_index, end_index - 1 do
                    table.insert(match_indices, {i, j})
                end
                    start_index = end_index  -- Перемещаем начальный индекс
            else
                start_index = start_index + 1  -- Переходим к следующему элементу
            end
        end
    end

    return match_indices  -- Возвращаем массив индексов совпадений
end


function game_model.can_triple(matrix) -- проверяем возможность триплета, матрица
  for x = 1, #matrix do
    for y = 1, #matrix[x] do
      
    local letter = matrix[x][y]
  
      if (y > 2 and matrix[x][y-1] == letter and matrix[x][y-2]) then 
        return true
      elseif (y < #matrix[x] - 1 and matrix[x][y+1] == letter and matrix[x][y+2] == letter) then 
        return true
      elseif (y > 1 and y <#matrix[x] and matrix[x][y-1] == letter and matrix[x][y+1] == letter) then 
        return true
      end
      
      if (x > 2 and matrix[x-1][y] == letter and matrix[x-2][y] == letter) then 
        return true
      elseif (x < #matrix - 1 and matrix[x+1][y] == letter and matrix[x+2][y] == letter) then 
        return true
      elseif (x > 1 and x < #matrix and matrix[x-1][y] == letter and matrix[x+1][y] == letter) then 
        return true
      end
    end
  end
  return false
end

return game_model