defmodule OnboardingElixir.Playground.ServerArrayTest do
  use ExUnit.Case, async: true

  alias OnboardingElixir.Playground.ArrayActions

  setup do
    server = ArrayActions.start_link()
    on_exit(fn -> Process.exit(server, :normal) end)
    %{server: server}
  end

  describe "operaciones básicas" do
    test "length retorna la longitud de la lista", %{server: server} do
      assert ArrayActions.length(server, [1, 2, 3]) == 3
      assert ArrayActions.length(server, []) == 0
    end

    test "first retorna el primer elemento", %{server: server} do
      assert ArrayActions.first(server, [5, 4, 3]) == {:ok, 5}
      assert ArrayActions.first(server, []) == {:error, :empty_list}
    end

    test "last retorna el último elemento", %{server: server} do
      assert ArrayActions.last(server, [5, 4, 3]) == {:ok, 3}
      assert ArrayActions.last(server, []) == {:error, :empty_list}
    end

    test "reverse invierte el orden", %{server: server} do
      assert ArrayActions.reverse(server, [1, 2, 3]) == [3, 2, 1]
    end

    test "drop elimina los primeros n elementos", %{server: server} do
      assert ArrayActions.drop(server, [5, 4, 3], 1) == [4, 3]
    end
  end

  describe "combinación y construcción" do
    test "concat_append une dos listas y agrega un elemento al final", %{server: server} do
      assert ArrayActions.concat_append(server, [5, 4, 3], [1, 2], 4) == [5, 4, 3, 1, 2, 4]
    end
  end
end
