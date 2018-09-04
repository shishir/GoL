defmodule GameOfLife do

  def keep_alive?(cells, {x,y}) do
    count_neighbours(cells, x, y, 0) > 1
  end

  def become_alive?(cells, {x,y}) do
    count_neighbours(cells, x, y, 0) == 3
  end

  def play(alive_cells, dead_cells) do
    # keep_alive?(tl(alive_cells)), hd(alive_cells))
  end

  defp count_neighbours([head|tail], x, y, count) do
    increment = case head do
      {hx, hy} when hx == x - 1 and hy == y - 1 -> 1
      {hx, hy} when hx == x     and hy == y - 1 -> 1
      {hx, hy} when hx == x - 1 and hy == y -> 1
      {hx, hy} when hx == x + 1 and hy == y + 1 -> 1
      {hx, hy} when hx == x     and hy == y + 1 -> 1
      {hx, hy} when hx == x + 1 and hy == y -> 1
      _foo -> 0
    end
    count_neighbours(tail, x, y, count + increment)
  end
  defp count_neighbours([], x, y, count) do
    count
  end
end
