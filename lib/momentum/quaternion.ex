defmodule Momentum.Quaternion do
  @type quaternion :: {float, float, float, float}

  @spec zero() :: quaternion()
  def zero, do: {0.0, 0.0, 0.0, 0.0}

  @spec identity() :: quaternion()
  def identity, do: {1.0, 0.0, 0.0, 0.0}
end
