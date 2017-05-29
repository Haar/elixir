defmodule ExUnit.Spec.Helper do
  @separator "\n\t"

  def full_message(message, contexts) do
    messages = Enum.map(contexts, &(&1.name))

    [message|messages]
    |> Enum.reverse
    |> Enum.join(@separator)
    |> List.insert_at(0, @separator)
  end
end
