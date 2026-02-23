alias OnboardingElixir.Playground.Math
alias OnboardingElixir.Playground.TaxCalculator

Math.sum(500,500)|> TaxCalculator.calc() |> Map.get(:total) |> IO.puts()