defmodule OnboardingElixir.Playground.GeometryServer do
  def start_link do
    spawn_link(fn -> loop() end)
  end

  def rectangle_area(server_pid, a, b) do
    send(server_pid, {:rectangle_area, a, b, self()})

    receive do
      {:result, result} -> result
    end
  end

  defp loop do
    receive do
      {:rectangle_area, a, b, caller} ->
        send(caller, {:result, a * b})
        loop()
    end
  end
end
