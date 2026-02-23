defmodule OnboardingElixir.Playground.AdderServerTest do
  use ExUnit.Case, async: true

  alias OnboardingElixir.Playground.AdderServer

  test "adds two numbers" do
    server = AdderServer.start_link()
    on_exit(fn -> Process.exit(server, :normal) end)
    assert AdderServer.add(server, 2, 3) == 5
    assert AdderServer.add(server, 10, 7) == 17
  end
end
