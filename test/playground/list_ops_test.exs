defmodule OnboardingElixir.Playground.ListOpsTest do
  use ExUnit.Case, async: true

  alias OnboardingElixir.Playground.ListOps

  describe "map/2" do
    test "transforma cada elemento con la función dada" do
      assert ListOps.map([1, 2, 3], &(&1 * 2)) == [2, 4, 6]
    end

    test "lista vacía retorna lista vacía" do
      assert ListOps.map([], &(&1 + 1)) == []
    end
  end

  describe "filter/2" do
    test "filtra elementos que cumplen el predicado" do
      assert ListOps.filter([1, 2, 3, 4, 5], &(&1 > 2)) == [3, 4, 5]
    end

    test "lista vacía retorna lista vacía" do
      assert ListOps.filter([], &(&1 > 0)) == []
    end
  end

  describe "sum/1" do
    test "suma los números de la lista" do
      assert ListOps.sum([1, 2, 3, 4, 5]) == 15
    end

    test "lista vacía retorna 0" do
      assert ListOps.sum([]) == 0
    end

    test "un solo elemento retorna ese elemento" do
      assert ListOps.sum([42]) == 42
    end
  end

  describe "group_by/2" do
    test "agrupa elementos por la clave" do
      list = [1, 2, 3, 4, 5, 6]
      result = ListOps.group_by(list, &rem(&1, 2))

      assert result[0] == [2, 4, 6]
      assert result[1] == [1, 3, 5]
    end

    test "lista vacía retorna mapa vacío" do
      assert ListOps.group_by([], & &1) == %{}
    end
  end

  describe "chunk_every/2" do
    test "divide la lista en chunks de tamaño n" do
      assert ListOps.chunk_every([1, 2, 3, 4, 5, 6], 2) == [[1, 2], [3, 4], [5, 6]]
    end

    test "lista más corta que n produce un chunk parcial" do
      assert ListOps.chunk_every([1, 2, 3], 2) == [[1, 2], [3]]
    end

    test "lista vacía retorna lista vacía" do
      assert ListOps.chunk_every([], 3) == []
    end
  end

  describe "reverse/1" do
    test "invierte el orden de la lista" do
      assert ListOps.reverse([1, 2, 3]) == [3, 2, 1]
    end

    test "lista vacía retorna lista vacía" do
      assert ListOps.reverse([]) == []
    end
  end

  describe "concat/2" do
    test "concatena dos listas" do
      assert ListOps.concat([1, 2], [3, 4]) == [1, 2, 3, 4]
    end

    test "concatena con lista vacía" do
      assert ListOps.concat([1, 2], []) == [1, 2]
      assert ListOps.concat([], [1, 2]) == [1, 2]
    end
  end
end
