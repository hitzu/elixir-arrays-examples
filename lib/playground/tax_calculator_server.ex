defmodule OnboardingElixir.Playground.TaxCalculatorServer do
  def start_link do
    spawn_link(fn -> loop() end)
  end

  def calc(server_pid, subtotal) do
    send(server_pid, {:calc, subtotal, self()})

    receive do
      {:result, result} -> result
    end
  end

  defp loop do
    receive do
      {:calc, subtotal, caller} -> 
       iva = 0.16

       result = %{
        subtotal: subtotal,
        impuesto: subtotal * iva,
        total: subtotal * (1 + iva)
       }

       send(caller, {:result, result})
       loop()

      _ -> loop()
    end
  end
end