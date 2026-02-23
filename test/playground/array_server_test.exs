defmodule OnboardingElixir.Playground.ArrayServerTest do
  use ExUnit.Case, async: true

  alias OnboardingElixir.Playground.ArrayServer

  setup do
    server = ArrayServer.start_link()
    on_exit(fn -> Process.exit(server, :normal) end)
    %{server: server}
  end

  describe "operaciones básicas" do
    test "length retorna la longitud de la lista", %{server: server} do
      assert ArrayServer.length(server, [1, 2, 3]) == 3
      assert ArrayServer.length(server, []) == 0
    end

    test "first retorna el primer elemento", %{server: server} do
      assert ArrayServer.first(server, [5, 4, 3]) == {:ok, 5}
      assert ArrayServer.first(server, []) == {:error, :empty_list}
    end

    test "last retorna el último elemento", %{server: server} do
      assert ArrayServer.last(server, [1, 2, 9]) == {:ok, 9}
      assert ArrayServer.last(server, []) == {:error, :empty_list}
    end

    test "head retorna la cabeza de la lista", %{server: server} do
      assert ArrayServer.head(server, [:a, :b, :c]) == {:ok, :a}
    end

    test "tail retorna el resto sin el primer elemento", %{server: server} do
      assert ArrayServer.tail(server, [1, 2, 3]) == {:ok, [2, 3]}
      assert ArrayServer.tail(server, [1]) == {:ok, []}
    end

    test "reverse invierte el orden", %{server: server} do
      assert ArrayServer.reverse(server, [1, 2, 3]) == [3, 2, 1]
    end
  end

  describe "combinación y construcción" do
    test "concat une dos listas", %{server: server} do
      assert ArrayServer.concat(server, [1, 2], [3, 4]) == [1, 2, 3, 4]
    end

    test "append agrega al final", %{server: server} do
      assert ArrayServer.append(server, [1, 2], 3) == [1, 2, 3]
    end

    test "prepend agrega al inicio", %{server: server} do
      assert ArrayServer.prepend(server, [2, 3], 1) == [1, 2, 3]
    end
  end

  describe "acceso por índice y rebanadas" do
    test "at retorna elemento en índice", %{server: server} do
      assert ArrayServer.at(server, [10, 20, 30], 1) == 20
      assert ArrayServer.at(server, [10, 20], 5) == nil
    end

    test "take toma n elementos", %{server: server} do
      assert ArrayServer.take(server, [1, 2, 3, 4], 2) == [1, 2]
    end

    test "drop elimina los primeros n", %{server: server} do
      assert ArrayServer.drop(server, [1, 2, 3, 4], 2) == [3, 4]
    end
  end

  describe "agregaciones numéricas" do
    test "sum suma todos los elementos", %{server: server} do
      assert ArrayServer.sum(server, [1, 2, 3]) == 6
      assert ArrayServer.sum(server, []) == 0
    end

    test "min retorna el mínimo", %{server: server} do
      assert ArrayServer.min(server, [3, 1, 4, 2]) == {:ok, 1}
      assert ArrayServer.min(server, []) == {:error, :empty_list}
    end

    test "max retorna el máximo", %{server: server} do
      assert ArrayServer.max(server, [3, 1, 4, 2]) == {:ok, 4}
      assert ArrayServer.max(server, []) == {:error, :empty_list}
    end
  end

  describe "transformaciones" do
    test "flatten aplana lista anidada", %{server: server} do
      assert ArrayServer.flatten(server, [[1, 2], [3, 4]]) == [1, 2, 3, 4]
    end

    test "zip combina dos listas en tuplas", %{server: server} do
      assert ArrayServer.zip(server, [1, 2], [:a, :b]) == [{1, :a}, {2, :b}]
    end

    test "uniq elimina duplicados consecutivos", %{server: server} do
      assert ArrayServer.uniq(server, [1, 1, 2, 2, 3]) == [1, 2, 3]
    end

    test "sort ordena la lista", %{server: server} do
      assert ArrayServer.sort(server, [3, 1, 4, 2]) == [1, 2, 3, 4]
    end
  end

  describe "búsqueda y predicados" do
    test "member? verifica si existe el elemento", %{server: server} do
      assert ArrayServer.member?(server, [1, 2, 3], 2) == true
      assert ArrayServer.member?(server, [1, 2, 3], 5) == false
    end

    test "index_of retorna el índice del elemento", %{server: server} do
      assert ArrayServer.index_of(server, [:a, :b, :c], :b) == 1
      assert ArrayServer.index_of(server, [:a, :b], :z) == nil
    end

    test "join une strings con separador", %{server: server} do
      assert ArrayServer.join(server, ["a", "b", "c"], "-") == "a-b-c"
    end

    test "empty? verifica si la lista está vacía", %{server: server} do
      assert ArrayServer.empty?(server, []) == true
      assert ArrayServer.empty?(server, [1]) == false
    end

    test "partition_even_odd separa pares e impares", %{server: server} do
      assert ArrayServer.partition_even_odd(server, [1, 2, 3, 4]) == {[2, 4], [1, 3]}
    end
  end
end
