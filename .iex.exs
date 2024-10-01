defmodule TestItOut do
  defp shift_offset(elements) do
    elements
    |> List.last
    |> Map.get(:offset)
    |> Kernel.+(1)
  end
  defp shift_offset_and_stream(elements, stream) do
    stream = %{stream | fetch_request: %{stream.fetch_request | offset: shift_offset(elements)}}
    {shift_offset(elements), stream}
  end

  def carry_out_operations(stream) do
    IO.inspect "Expecting count of numbers to sum"
    buffer_size_elements = Enum.take(stream, 1)
    buffer_size =
      buffer_size_elements
      |> hd
      |> Map.get(:value)
      |> String.to_integer
    offset = shift_offset(buffer_size_elements)
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
