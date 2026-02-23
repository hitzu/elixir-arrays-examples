defmodule OnboardingElixir.Playground.ArrayActions do
  def start_link do
    spawn_link(fn -> loop() end)
  end

  def length(server_pid, list) do
    call(server_pid, {:length, list})
  end

  def first(server_pid, list) do
    call(server_pid, {:first, list})
  end

  def last(server_pid, list) do
    call(server_pid, {:last, list})
  end

  def reverse(server_pid, list) do 
    call(server_pid, {:reverse, list})
  end

  def concat_append(server_pid, list1, list2, new_element) do
    call(server_pid, {:concat_append, list1, list2, new_element})
  end

  def drop(server_pid, list, n) do
    call(server_pid, {:drop, list, n})
  end

  # Aqui podemos reusar la funcion call
  # si no estariamos repitiendo el send y el receive en todos los metodos
  defp call(server_pid, message) do
    send(server_pid, {message, self()})
    receive do
      {:result, result} -> result
    end
  end

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

      {{:reverse, list}, caller} ->
        send(caller, {:result, Enum.reverse(list)})
        loop()

      {{:concat_append, list1, list2, new_element}, caller} ->
        list_together = list1 ++ list2
        send(caller, {:result, list_together ++ [new_element]})
        loop()
      
      {{:drop, list, n}, caller} ->
        send(caller, {:result, Enum.drop(list,n)})
    end
  end  
end