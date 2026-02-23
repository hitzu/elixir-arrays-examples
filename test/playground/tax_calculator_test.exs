defmodule OnboardingElixir.Playground.TaxCalculatorTest do
  use ExUnit.Case, async: true

  alias OnboardingElixir.Playground.TaxCalculator

  describe "calc/1" do
    test "returns subtotal, impuesto, and total for given amount" do
      result = TaxCalculator.calc(1000)

      assert result.subtotal == 1000
      assert result.impuesto == 160.0
      assert result.total == 1160.0
    end

    test "applies 16% IVA" do
      result = TaxCalculator.calc(100)

      assert result.subtotal == 100
      assert result.impuesto == 16.0
      assert_in_delta result.total, 116.0, 0.01
    end

    test "handles zero" do
      result = TaxCalculator.calc(0)

      assert result.subtotal == 0
      assert result.impuesto == 0.0
      assert result.total == 0.0
    end
  end
end
