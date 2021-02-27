defmodule Momentum.Vector3 do
  def zero do
    {0, 0, 0}
  end

  # There are much better algorithms for this stuff, obviously
  def random do
    {:rand.uniform() * 2 - 1, :rand.uniform() * 2 - 1, :rand.uniform() * 2 - 1}
  end

  def scale({x, y, z}, n) do
    {x * n, y * n, z * n}
  end
end
