defmodule OnboardingElixir.Playground.ListOps do
  @moduledoc """
  Funciones de transformación de listas en estilo Elixir happy path.
  Usa Enum.map, filter, reduce, group_by, chunk_every.
  """

  @doc "Transforma cada elemento con la función dada."
  def map(list, fun) when is_list(list) and is_function(fun, 1), do: Enum.map(list, fun)

  @doc "Filtra elementos que cumplen el predicado."
  def filter(list, predicate) when is_list(list) and is_function(predicate, 1),
    do: Enum.filter(list, predicate)

  @doc "Suma los números de la lista usando reduce de forma idiomática."
  def sum(list) when is_list(list) do
    Enum.reduce(list, 0, fn x, acc -> x + acc end)
  end

  @doc "Agrupa elementos por la clave retornada por key_fun."
  def group_by(list, key_fun) when is_list(list) and is_function(key_fun, 1),
    do: Enum.group_by(list, key_fun)

  @doc "Divide la lista en chunks de tamaño n."
  def chunk_every(list, n) when is_list(list) and is_integer(n) and n > 0,
    do: Enum.chunk_every(list, n)

  @doc "Invierte el orden de la lista."
  def reverse(list) when is_list(list), do: Enum.reverse(list)

  @doc "Concatena dos listas."
  def concat(list1, list2) when is_list(list1) and is_list(list2), do: list1 ++ list2
end
