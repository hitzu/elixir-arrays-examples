defmodule OnboardingElixirTest do
  use ExUnit.Case
  doctest OnboardingElixir

  test "greets the world" do
    assert OnboardingElixir.hello() == :world
  end
end
