defmodule TestItOut do
  def shift_offset_and_stream(elements, stream) do
    offset =
      elements
      |> List.last
      |> Map.get(:offset)
      |> Kernel.+(1)
    stream = %{stream | fetch_request: %{stream.fetch_request | offset: offset}}
    {offset, stream}
  end

  def carry_out_operations(stream) do
    IO.inspect "Expecting count of numbers to sum"
    buffer_size_element = Enum.take(stream, 1) |> hd
    buffer_size =
      buffer_size_element
      |> Map.get(:value)
      |> String.to_integer
    offset =
      buffer_size_element
      |> Map.get(:offset)
      |> Kernel.+(1)
    stream = %{stream | fetch_request: %{stream.fetch_request | offset: offset}}
    IO.inspect "Will be summing up #{buffer_size} numbers"
    elements = Enum.take(stream, buffer_size)
    sum =
      elements
      |> Enum.map(fn elem -> String.to_integer(elem.value) end)
      |> Enum.sum()
    {offset, updated_stream} = shift_offset_and_stream(elements, stream)
    IO.inspect("Sum of #{buffer_size} inputs is: #{sum}, new offset: #{offset}")
    carry_out_operations(updated_stream)
  end
end

topic = "test"
stream = KafkaEx.stream(topic, 0)
TestItOut.carry_out_operations(stream)
