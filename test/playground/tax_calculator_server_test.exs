defmodule OnboardingElixir.Playground.TaxCalculatorServerTest do
  use ExUnit.Case, async: true

  alias OnboardingElixir.Playground.TaxCalculatorServer

  describe "02_server_tax_calculator script behavior" do
    test "calc returns total for given amount" do
      server = TaxCalculatorServer.start_link()
      on_exit(fn -> Process.exit(server, :normal) end)

      result = TaxCalculatorServer.calc(server, 1000)

      assert result.subtotal == 1000
      assert result.impuesto == 160.0
      assert result.total == 1160.0
    end

    test "server handles multiple calc requests" do
      server = TaxCalculatorServer.start_link()
      on_exit(fn -> Process.exit(server, :normal) end)

      result1 = TaxCalculatorServer.calc(server, 100)
      result2 = TaxCalculatorServer.calc(server, 500)

      assert_in_delta result1.total, 116.0, 0.01
      assert_in_delta result2.total, 580.0, 0.01
    end
  end
end
