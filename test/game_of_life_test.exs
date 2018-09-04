defmodule GameOfLifeTest do
  use ExUnit.Case
  doctest GameOfLife

  test "alive cells with no neighbour dies" do
    alive_cell = {1,1}
    alive_cells = [{1,1}]
    refute GameOfLife.keep_alive?(alive_cells, alive_cell)
  end

  test "alive cells with 1 neighbour dies" do
    alive_cell = {1,1}

    refute GameOfLife.keep_alive?([alive_cell]++[{0,0}], alive_cell)
    refute GameOfLife.keep_alive?([alive_cell]++[{0,1}], alive_cell)
    refute GameOfLife.keep_alive?([alive_cell]++[{1,0}], alive_cell)
  end

  test "alive cells with 2 neighbors survives" do
    alive_cell = {1,1}
    assert GameOfLife.keep_alive?([alive_cell]++[{0,0}, {0,1}], alive_cell)
    assert GameOfLife.keep_alive?([alive_cell]++[{0,0}, {0,1}], alive_cell)
  end

  test "alive cells with 3 neighbors survives" do
    alive_cell = {1,1}
    assert GameOfLife.keep_alive?([alive_cell]++[{0,0}, {0,1}, {1,0}], alive_cell)
  end

  test "dead cells become alive when they have exactly three alive neighbors" do
    alive_cells = [{1,1}, {0,1}, {1,0}]
    assert GameOfLife.become_alive?(alive_cells, {0,0})
  end

  test "next generation" do
    alive_cells = [{1,1}, {0,1}, {1,0}]
    dead_cells = [{0,0}]
    {alive_cells, dead_cells} = GameOfLife.play(alive_cells, dead_cells)
    assert alive_cells == [{1,1}, {0,1}, {1,0}, {1,1}]
    assert dead_cells == []
  end
end
