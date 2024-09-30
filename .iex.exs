buffer_size = 100
topic = "test"
stream = KafkaEx.stream(topic, 0)
elements = Enum.take(stream, buffer_size)
offset = 
  elements
  |> List.last
  |> Map.get(:offset)
  |> Kernel.+(1)
sum =
  elements
  |> Enum.map(fn elem -> String.to_integer(elem.value) end)
  |> Enum.sum()
IO.inspect("Sum of #{buffer_size} inputs is: #{sum}, new offset: #{offset}")
stream = %{stream | fetch_request: %{stream.fetch_request | offset: offset}}
