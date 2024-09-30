defmodule KafkaPotionTest do
  use ExUnit.Case
  doctest KafkaPotion

  test "greets the world" do
    assert KafkaPotion.hello() == :world
  end
end
