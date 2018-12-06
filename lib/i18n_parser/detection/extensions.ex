defmodule I18nParser.Detection.Extensions do
  @moduledoc """
  Module for detecting
  """

  defmacro __using__(_opts) do
    quote do
      defp detect_locale(file, extension) when extension == "yml" do
        {:ok, yml} = file |> YamlElixir.read_from_file()
        keys = yml |> Map.keys()
        if length(keys) != 1, do: raise "Invalid amount of keys"
        locale = keys |> Enum.at(0)
        cond do
          String.length(locale) == 2 ->
            {:ok, %{code: locale}}
          String.length(locale) == 5 && String.at(locale, 2) == "-" ->
            {:ok, %{code: String.slice(locale, 0..1)}}
          true ->
            {:error, "Invalid format of locale"}
        end
      end
    end
  end
end
