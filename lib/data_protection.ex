defmodule Windows.API.DataProtection do
  @doc """
  Wraps a binary for the given user.

  ## Examples

    iex> "some confidential input value"
    ...> |> Windows.API.DataProtection.wrap()
    ...> |> byte_size()
    ...> |> (fn length -> length > 0 end).()
    true
  """
  def wrap(binary) when is_binary(binary) do
    Windows.API.DataProtection.Native.nif_wrap(binary)
  end

  @doc """
  Unwraps a binary for the given user.

  ## Examples

    Demonstration of the round-trip property:

    iex> "some confidential input value"
    ...> |> Windows.API.DataProtection.wrap()   # encrypt/wrap
    ...> |> Windows.API.DataProtection.unwrap() # decrypt/unwrap
    "some confidential input value"

  """
  def unwrap(binary) when is_binary(binary) do
    Windows.API.DataProtection.Native.nif_unwrap(binary)
  end
end
