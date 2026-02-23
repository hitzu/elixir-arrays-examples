# Lanzador del ArrayServer - demuestra todas las operaciones sobre listas
# Ejecutar con: mix run playground/02_server_array.exs

alias OnboardingElixir.Playground.ArrayServer

server = ArrayServer.start_link()

IO.puts("=== ArrayServer - Operaciones sobre listas ===\n")

# Operaciones básicas
IO.puts("--- Básicas ---")
IO.puts("length([1,2,3]) = #{ArrayServer.length(server, [1, 2, 3])}")
IO.puts("first([5,4,3]) = #{inspect(ArrayServer.first(server, [5, 4, 3]))}")
IO.puts("last([1,2,9]) = #{inspect(ArrayServer.last(server, [1, 2, 9]))}")
IO.puts("head([:a,:b,:c]) = #{inspect(ArrayServer.head(server, [:a, :b, :c]))}")
IO.puts("tail([1,2,3]) = #{inspect(ArrayServer.tail(server, [1, 2, 3]))}")
IO.puts("reverse([1,2,3]) = #{inspect(ArrayServer.reverse(server, [1, 2, 3]))}")

# Combinación
IO.puts("\n--- Combinación ---")
IO.puts("concat([1,2],[3,4]) = #{inspect(ArrayServer.concat(server, [1, 2], [3, 4]))}")
IO.puts("append([1,2], 3) = #{inspect(ArrayServer.append(server, [1, 2], 3))}")
IO.puts("prepend([2,3], 1) = #{inspect(ArrayServer.prepend(server, [2, 3], 1))}")

# Acceso y rebanadas
IO.puts("\n--- Acceso ---")
IO.puts("at([10,20,30], 1) = #{ArrayServer.at(server, [10, 20, 30], 1)}")
IO.puts("take([1,2,3,4], 2) = #{inspect(ArrayServer.take(server, [1, 2, 3, 4], 2))}")
IO.puts("drop([1,2,3,4], 2) = #{inspect(ArrayServer.drop(server, [1, 2, 3, 4], 2))}")

# Agregaciones
IO.puts("\n--- Agregaciones ---")
IO.puts("sum([1,2,3]) = #{ArrayServer.sum(server, [1, 2, 3])}")
IO.puts("min([3,1,4,2]) = #{inspect(ArrayServer.min(server, [3, 1, 4, 2]))}")
IO.puts("max([3,1,4,2]) = #{inspect(ArrayServer.max(server, [3, 1, 4, 2]))}")

# Transformaciones
IO.puts("\n--- Transformaciones ---")
IO.puts("flatten([[1,2],[3,4]]) = #{inspect(ArrayServer.flatten(server, [[1, 2], [3, 4]]))}")
IO.puts("zip([1,2], [:a,:b]) = #{inspect(ArrayServer.zip(server, [1, 2], [:a, :b]))}")
IO.puts("uniq([1,1,2,2,3]) = #{inspect(ArrayServer.uniq(server, [1, 1, 2, 2, 3]))}")
IO.puts("sort([3,1,4,2]) = #{inspect(ArrayServer.sort(server, [3, 1, 4, 2]))}")

# Búsqueda
IO.puts("\n--- Búsqueda ---")
IO.puts("member?([1,2,3], 2) = #{ArrayServer.member?(server, [1, 2, 3], 2)}")
IO.puts("index_of([:a,:b,:c], :b) = #{ArrayServer.index_of(server, [:a, :b, :c], :b)}")
IO.puts("join([\"a\",\"b\",\"c\"], \"-\") = #{ArrayServer.join(server, ["a", "b", "c"], "-")}")
IO.puts("empty?([]) = #{ArrayServer.empty?(server, [])}")
IO.puts("partition_even_odd([1,2,3,4]) = #{inspect(ArrayServer.partition_even_odd(server, [1, 2, 3, 4]))}")

IO.puts("\n=== Fin ===")
