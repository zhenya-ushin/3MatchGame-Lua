local game_visual = {}
function game_visual.print_matrix(matrix) -- матрица
  io.write("\n |0|1|2|3|4|5|6|7|8|9|\n")
  io.write("-------------------------\n")
  for i = 1, #matrix do
    io.write(i-1,"|")
    for j = 1, #matrix[i] do
    io.write(matrix[i][j], " ")
    end
  io.write("\n")
  end
end
return game_visual
