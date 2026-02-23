alias OnboardingElixir.Playground.AdderServer

server = AdderServer.start_link()

IO.puts("2 + 3 = #{AdderServer.add(server, 2, 3)}")
IO.puts("10 + 7 = #{AdderServer.add(server, 10, 7)}")
