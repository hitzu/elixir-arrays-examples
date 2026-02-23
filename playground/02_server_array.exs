alias OnboardingElixir.Playground.ArrayActions

server = ArrayActions.start_link()

IO.puts("=== ArrayActions - Operaciones sobre listas ===\n")

IO.puts("--- Básicas ---")
IO.puts("length([1,2,3]) = #{ArrayActions.length(server, [1, 2, 3])}")
IO.puts("first([5,4,3]) = #{inspect(ArrayActions.first(server, [5, 4, 3]))}")
IO.puts("first([]) = #{inspect(ArrayActions.first(server, []))}")
IO.puts("last([5,4,3]) = #{inspect(ArrayActions.last(server, [5, 4, 3]))}")
IO.puts("last([]) = #{inspect(ArrayActions.last(server, []))}")
IO.puts("reverse([1,2,3]) = #{inspect(ArrayActions.reverse(server, [1,2,3]))}")
IO.puts("concat_append([5,4,3]) = #{inspect(ArrayActions.concat_append(server, [5, 4, 3], [1, 2], 4))}")
IO.puts("drop([5,4,3]) = #{inspect(ArrayActions.drop(server, [5, 4, 3], 1))}")


IO.puts("\n=== Fin ===")
