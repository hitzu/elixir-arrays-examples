defmodule OnboardingElixir.Playground.ArrayServer do
  @moduledoc """
  Servidor de procesos que ejecuta operaciones sobre listas (arrays).
  Patrón actor: cada operación se envía como mensaje y se espera una respuesta.
  """

  # ---------------------------------------------------------------------------
  # INICIO DEL SERVIDOR
  # ---------------------------------------------------------------------------

  @doc """
  Inicia el servidor como un proceso enlazado.
  spawn_link crea un proceso hijo; si este muere, el padre es notificado.
  """
  def start_link do
    spawn_link(fn -> loop() end)
  end

  # ---------------------------------------------------------------------------
  # API PÚBLICA - OPERACIONES BÁSICAS
  # ---------------------------------------------------------------------------

  @doc """
  Retorna la longitud de la lista.
  En Elixir las listas son listas enlazadas, O(n) para length.
  """
  def length(server_pid, list) do
    call(server_pid, {:length, list})
  end

  @doc """
  Primer elemento de la lista.
  Fallará si la lista está vacía (case vacío).
  """
  def first(server_pid, list) do
    call(server_pid, {:first, list})
  end

  @doc """
  Último elemento. Requiere recorrer toda la lista → O(n).
  """
  def last(server_pid, list) do
    call(server_pid, {:last, list})
  end

  @doc """
  Sinónimo de first: cabeza de la lista (head).
  """
  def head(server_pid, list) do
    call(server_pid, {:head, list})
  end

  @doc """
  Resto de la lista sin el primer elemento (tail).
  En listas enlazadas, O(1) ya que es solo un puntero.
  """
  def tail(server_pid, list) do
    call(server_pid, {:tail, list})
  end

  @doc """
  Invierte el orden de los elementos.
  """
  def reverse(server_pid, list) do
    call(server_pid, {:reverse, list})
  end

  # ---------------------------------------------------------------------------
  # API PÚBLICA - COMBINACIÓN Y CONSTRUCCIÓN
  # ---------------------------------------------------------------------------

  @doc """
  Concatena dos listas. list1 ++ list2 crea una copia de list1.
  Preferir Enum.concat cuando no sea crítica la performance.
  """
  def concat(server_pid, list1, list2) do
    call(server_pid, {:concat, list1, list2})
  end

  @doc """
  Agrega un elemento al final de la lista.
  Nota: en listas enlazadas, append es O(n); prepend es O(1).
  """
  def append(server_pid, list, elem) do
    call(server_pid, {:append, list, elem})
  end

  @doc """
  Agrega un elemento al inicio (cons en Lisp).
  Operación O(1) en listas enlazadas.
  """
  def prepend(server_pid, list, elem) do
    call(server_pid, {:prepend, list, elem})
  end

  # ---------------------------------------------------------------------------
  # API PÚBLICA - ACCESO POR ÍNDICE Y REBANADAS
  # ---------------------------------------------------------------------------

  @doc """
  Elemento en el índice (0-based).
  nil si el índice está fuera de rango (comportamiento por defecto de Enum.at).
  """
  def at(server_pid, list, index) do
    call(server_pid, {:at, list, index})
  end

  @doc """
  Toma los primeros n elementos de la lista.
  """
  def take(server_pid, list, n) do
    call(server_pid, {:take, list, n})
  end

  @doc """
  Elimina los primeros n elementos y retorna el resto.
  """
  def drop(server_pid, list, n) do
    call(server_pid, {:drop, list, n})
  end

  # ---------------------------------------------------------------------------
  # API PÚBLICA - AGREGACIONES NUMÉRICAS
  # ---------------------------------------------------------------------------

  @doc """
  Suma todos los elementos numéricos de la lista.
  Retorna 0 para lista vacía.
  """
  def sum(server_pid, list) do
    call(server_pid, {:sum, list})
  end

  @doc """
  Encuentra el elemento mínimo.
  Funciona con cualquier tipo comparable (números, strings, etc).
  """
  def min(server_pid, list) do
    call(server_pid, {:min, list})
  end

  @doc """
  Encuentra el elemento máximo.
  """
  def max(server_pid, list) do
    call(server_pid, {:max, list})
  end

  # ---------------------------------------------------------------------------
  # API PÚBLICA - TRANSFORMACIONES
  # ---------------------------------------------------------------------------

  @doc """
  Aplana una lista anidada un nivel.
  Ej: [[1,2],[3]] → [1,2,3]
  """
  def flatten(server_pid, list) do
    call(server_pid, {:flatten, list})
  end

  @doc """
  Combina dos listas en una lista de tuplas {elem1, elem2}.
  La longitud resultante es la del más corto.
  """
  def zip(server_pid, list1, list2) do
    call(server_pid, {:zip, list1, list2})
  end

  @doc """
  Elimina duplicados consecutivos.
  Para eliminar todos los duplicados: ordenar primero y luego uniq, o usar Enum.uniq_by.
  """
  def uniq(server_pid, list) do
    call(server_pid, {:uniq, list})
  end

  @doc """
  Ordena la lista. Por defecto orden ascendente.
  """
  def sort(server_pid, list) do
    call(server_pid, {:sort, list})
  end

  # ---------------------------------------------------------------------------
  # API PÚBLICA - BÚSQUEDA Y PREDICADOS
  # ---------------------------------------------------------------------------

  @doc """
  Verifica si el elemento está en la lista.
  Retorna true/false. O(n) en el peor caso.
  """
  def member?(server_pid, list, elem) do
    call(server_pid, {:member, list, elem})
  end

  @doc """
  Índice del primer elemento que coincide, o nil si no existe.
  """
  def index_of(server_pid, list, elem) do
    call(server_pid, {:index_of, list, elem})
  end

  @doc """
  Une una lista de strings (o convertibles a string) con un separador.
  Ej: join(["a","b","c"], "-") → "a-b-c"
  """
  def join(server_pid, list, separator) do
    call(server_pid, {:join, list, separator})
  end

  @doc """
  Verifica si la lista está vacía.
  """
  def empty?(server_pid, list) do
    call(server_pid, {:empty, list})
  end

  @doc """
  Particiona la lista en dos: elementos que cumplen y que no cumplen la función.
  Pasamos el módulo y función como átomos para evitar serializar closures.
  Ej: partition(pid, [1,2,3,4], Integer, :odd?)  # requiere función guardada
  Por simplicidad, usamos :even y :odd como átomos para números.
  """
  def partition_even_odd(server_pid, list) do
    call(server_pid, {:partition_even_odd, list})
  end

  # ---------------------------------------------------------------------------
  # FUNCIÓN GENÉRICA DE LLAMADA
  # ---------------------------------------------------------------------------

  # Patrón request-response: enviamos mensaje, esperamos {:result, data}.
  # Evita duplicar send/receive en cada función pública.
  defp call(server_pid, message) do
    send(server_pid, {message, self()})

    receive do
      {:result, result} -> result
    end
  end

  # ---------------------------------------------------------------------------
  # LOOP PRINCIPAL - DISPATCH DE MENSAJES
  # ---------------------------------------------------------------------------

  defp loop do
    receive do
      {{:length, list}, caller} ->
        send(caller, {:result, Kernel.length(list)})
        loop()

      {{:first, list}, caller} ->
        result = case list do
          [] -> {:error, :empty_list}
          [h | _] -> {:ok, h}
        end
        send(caller, {:result, result})
        loop()

      {{:last, list}, caller} ->
        result = case list do
          [] -> {:error, :empty_list}
          l -> {:ok, List.last(l)}
        end
        send(caller, {:result, result})
        loop()

      {{:head, list}, caller} ->
        result = case list do
          [] -> {:error, :empty_list}
          [h | _] -> {:ok, h}
        end
        send(caller, {:result, result})
        loop()

      {{:tail, list}, caller} ->
        result = case list do
          [] -> {:error, :empty_list}
          [_ | t] -> {:ok, t}
        end
        send(caller, {:result, result})
        loop()

      {{:reverse, list}, caller} ->
        send(caller, {:result, Enum.reverse(list)})
        loop()

      {{:concat, list1, list2}, caller} ->
        send(caller, {:result, list1 ++ list2})
        loop()

      {{:append, list, elem}, caller} ->
        send(caller, {:result, list ++ [elem]})
        loop()

      {{:prepend, list, elem}, caller} ->
        send(caller, {:result, [elem | list]})
        loop()

      {{:at, list, index}, caller} ->
        send(caller, {:result, Enum.at(list, index)})
        loop()

      {{:take, list, n}, caller} ->
        send(caller, {:result, Enum.take(list, n)})
        loop()

      {{:drop, list, n}, caller} ->
        send(caller, {:result, Enum.drop(list, n)})
        loop()

      {{:sum, list}, caller} ->
        send(caller, {:result, Enum.sum(list)})
        loop()

      {{:min, list}, caller} ->
        result = case list do
          [] -> {:error, :empty_list}
          l -> {:ok, Enum.min(l)}
        end
        send(caller, {:result, result})
        loop()

      {{:max, list}, caller} ->
        result = case list do
          [] -> {:error, :empty_list}
          l -> {:ok, Enum.max(l)}
        end
        send(caller, {:result, result})
        loop()

      {{:flatten, list}, caller} ->
        send(caller, {:result, List.flatten(list)})
        loop()

      {{:zip, list1, list2}, caller} ->
        send(caller, {:result, Enum.zip(list1, list2) |> Enum.to_list()})
        loop()

      {{:uniq, list}, caller} ->
        send(caller, {:result, Enum.uniq(list)})
        loop()

      {{:sort, list}, caller} ->
        send(caller, {:result, Enum.sort(list)})
        loop()

      {{:member, list, elem}, caller} ->
        send(caller, {:result, elem in list})
        loop()

      {{:index_of, list, elem}, caller} ->
        idx = Enum.find_index(list, &(&1 == elem))
        send(caller, {:result, idx})
        loop()

      {{:join, list, separator}, caller} ->
        send(caller, {:result, Enum.join(list, separator)})
        loop()

      {{:empty, list}, caller} ->
        send(caller, {:result, list == []})
        loop()

      {{:partition_even_odd, list}, caller} ->
        {evens, odds} = Enum.split_with(list, &(is_number(&1) and rem(&1, 2) == 0))
        send(caller, {:result, {evens, odds}})
        loop()
    end
  end
end
