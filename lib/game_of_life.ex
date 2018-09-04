defmodule GameOfLife do

  def keep_alive?(cells, {x,y}) do
    count_neighbours(cells, x, y, 0) > 1
  end

  def become_alive?(cells, {x,y}) do
    count_neighbours(cells, x, y, 0) == 3
  end

  def play(alive_cells, dead_cells) do
    play(alive_cells, alive_cells, [], &GameOfLife.keep_alive?/2)
    ++
    play(dead_cells, alive_cells, [], &GameOfLife.become_alive?/2)
  end

  defp play([head | tail],alive_cells,l, f) do
    if f.(alive_cells, head) do
      play(tail, alive_cells, l ++ [head], f)
    else
      play(tail, alive_cells , l, f)
    end
  end

  defp play([],_, l, _) do
    l
  end

  defp count_neighbours([head | tail], x, y, count) do
    increment = case head do
      {hx, hy} when hx == x - 1 and hy == y - 1 -> 1
      {hx, hy} when hx == x     and hy == y - 1 -> 1
      {hx, hy} when hx == x - 1 and hy == y -> 1
      {hx, hy} when hx == x + 1 and hy == y + 1 -> 1
      {hx, hy} when hx == x     and hy == y + 1 -> 1
      {hx, hy} when hx == x + 1 and hy == y -> 1
      {hx, hy} when hx == x - 1 and hy == y + 1-> 1
      {hx, hy} when hx == x + 1 and hy == y - 1-> 1
      _foo -> 0
    end
    count_neighbours(tail, x, y, count + increment)
  end
  defp count_neighbours([], _, _, count) do
    count
  end
end
