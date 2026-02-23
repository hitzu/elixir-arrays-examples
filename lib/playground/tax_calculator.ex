defmodule OnboardingElixir.Playground.TaxCalculator do
  @iva 0.16

  def calc(subtotal) do
    %{
      subtotal: subtotal,
      impuesto: subtotal * @iva,
      total: subtotal * (1 + @iva)
    }
  end
end
