alias OnboardingElixir.Playground.TaxCalculatorServer

server = TaxCalculatorServer.start_link()

result = TaxCalculatorServer.calc(server, 1000)
IO.puts("Total: #{result.total}")