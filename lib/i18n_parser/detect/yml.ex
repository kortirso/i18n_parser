defmodule I18nParser.Detect.Yml do
  @moduledoc """
  Module for detecting locale of the YML files
  """

  defmacro __using__(_opts) do
    quote do
      defp do_yml_detect(file) do
        case Yml.read_from_file(file) do
          {:ok, yml} -> detect_yml_locale(yml)
          result -> result
        end
      end

      defp detect_yml_locale(%{} = yml) do
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

      defp detect_yml_locale(_), do: {:error, "YML structure error"}

      defp is_simple_format(locale), do: String.length(locale) == 2

      defp is_compound_format(locale), do: String.length(locale) == 5 && String.at(locale, 2) == "-"
    end
  end
end
