defmodule OnboardingElixir.Playground.GeometryServerTest do
  use ExUnit.Case, async: true

  alias OnboardingElixir.Playground.GeometryServer

  test "computes rectangle area" do
    server = GeometryServer.start_link()
    on_exit(fn -> Process.exit(server, :normal) end)
    assert GeometryServer.rectangle_area(server, 5, 5) == 25
  end
end
