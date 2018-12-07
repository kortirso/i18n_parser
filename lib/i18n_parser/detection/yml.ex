defmodule I18nParser.Detection.Yml do
  @moduledoc """
  Module for detecting locale of the YML files
  """

  defmacro __using__(_opts) do
    quote do
      defp process_yml_file(file) do
        case YamlElixir.read_from_file(file) do
          {:ok, yml} -> detect_locale(yml)
          _ -> {:error, "Invalid YML format"}
        end
      end

      defp detect_locale(%{} = yml) do
        keys = Map.keys(yml)
        locale = Enum.at(keys, 0)
        cond do
          length(keys) != 1 ->
            {:error, "Invalid amount of keys"}

          is_binary(locale) == false ->
            {:error, "Locale is not string"}

          is_simple_format(locale) ->
            {:ok, %{code: locale}}

          is_compound_format(locale) ->
            {:ok, %{code: String.slice(locale, 0..1)}}

          true ->
            {:error, "Invalid format of locale"}
        end
      end

      defp detect_locale(_) do
        {:error, "YML structure error"}
      end

      defp is_simple_format(locale) do
        String.length(locale) == 2
      end

      defp is_compound_format(locale) do
        String.length(locale) == 5 && String.at(locale, 2) == "-"
      end
    end
  end
end
