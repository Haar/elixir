defmodule ExUnit.Spec do
  @moduledoc """
  """

  @doc false
  defmacro __using__(opts) do
    quote do
      use ExUnit.Case, unquote(opts)
      import ExUnit.Spec

      @ex_unit_contexts []
      @ex_unit_spec true
    end
  end

  defmacro context(message, do: body) do
    quote do
      previous_contexts = @ex_unit_contexts
      context = (case unquote(message) do
        msg when is_binary(msg) ->  %ExUnit.Spec.Context{name: unquote(message)}
        msg -> raise ArgumentError, "context name must be a string, got: #{inspect msg}"
      end)
      @ex_unit_contexts [context | previous_contexts]

      try do
        unquote(body)
      after
        @ex_unit_contexts previous_contexts
      end
    end
  end

  defmacro it(message) do
    quote do
      unquote(message)
      |> ExUnit.Spec.Helper.full_message(@ex_unit_contexts)
      |> ExUnit.Case.test
    end
  end

  defmacro it(message, var \\ quote(do: _), body) do
    quote do
      unquote(message)
      |> ExUnit.Spec.Helper.full_message(@ex_unit_contexts)
      |> ExUnit.Case.test(unquote(var), unquote(body))
    end
  end

end
