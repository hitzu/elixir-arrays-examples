defmodule OnboardingElixir.Playground.AdderServer do
  def start_link do
    spawn_link(fn -> loop() end)
  end

  def add(server_pid, a, b) do
    send(server_pid, {:add, a, b, self()})

    receive do
      {:result, result} -> result
    end
  end

  defp loop do
    receive do
      {:add, a, b, caller} ->
        send(caller, {:result, a + b})
        loop()
    end
  end
end
