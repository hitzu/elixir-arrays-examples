# ListOps - Estilo Elixir Happy Path y Enum
#
# Este script demuestra el uso idiomático de:
#   - Enum.map/2
#   - Enum.filter/2
#   - Enum.reduce/3
#   - Enum.group_by/2
#   - Enum.chunk_every/2
#
# Ejecutar: mix run playground/03_list_ops_enum.exs

alias OnboardingElixir.Playground.ListOps

IO.puts("\n=== ListOps: Estilo Elixir Happy Path ===\n")

# --- Enum.map: transformar cada elemento ---
IO.puts("1. map/2 - Transforma cada elemento con una función:")
nums = [1, 2, 3, 4, 5]
doubled = ListOps.map(nums, &(&1 * 2))
IO.inspect(doubled, label: "   [1,2,3,4,5] |> map(&(&1*2))")

# --- Enum.filter: filtrar por predicado ---
IO.puts("\n2. filter/2 - Filtra elementos que cumplen el predicado:")
evens = ListOps.filter(nums, &(rem(&1, 2) == 0))
IO.inspect(evens, label: "   pares de [1..5]")

# --- Enum.reduce: acumular de forma idiomática ---
IO.puts("\n3. reduce (sum/1) - Acumula con valor inicial:")
total = ListOps.sum(nums)
IO.inspect(total, label: "   sum([1..5])")

# --- Enum.group_by: agrupar por clave ---
IO.puts("\n4. group_by/2 - Agrupa por la clave retornada por key_fun:")
words = ["hola", "mundo", "elixir", "lista", "mapa"]
by_length = ListOps.group_by(words, &String.length/1)
IO.inspect(by_length, label: "   group_by(words, &String.length/1)")

# --- Enum.chunk_every: dividir en bloques ---
IO.puts("\n5. chunk_every/2 - Divide la lista en chunks de tamaño n:")
chunks = ListOps.chunk_every(nums, 2)
IO.inspect(chunks, label: "   chunk_every([1..5], 2)")

# --- Happy path: encadenar transformaciones ---
IO.puts("\n6. Happy path - Encadenar con pipes:")
result =
  [1, 2, 3, 4, 5, 6]
  |> ListOps.filter(&(rem(&1, 2) == 0))
  |> ListOps.map(&(&1 * 10))
  |> ListOps.sum()

IO.inspect(result, label: "   pares * 10, luego sumar")

IO.puts("\n")
