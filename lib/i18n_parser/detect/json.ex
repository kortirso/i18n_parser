defmodule I18nParser.Detect.Json do
  @moduledoc """
  Module for detecting locale of the Json files
  """

  defmacro __using__(_opts) do
    quote do
      defp do_detect_json(file) do
        with {:ok, body} <- File.read(file),
             {:ok, json} <- Poison.decode(body),
             {:ok, result} <- detect_json_locale(json) do
               {:ok, result}
        else
          {:locale_error, error_value} -> detect_json_locale_by_filename(file, error_value)
          _ -> {:error, "File reading error"}
        end
      end

      defp detect_json_locale(%{} = json) do
        keys = Map.keys(json)
        locale = Enum.at(keys, 0)
        cond do
          length(keys) != 1 ->
            {:locale_error, "Invalid amount of keys"}

          is_binary(locale) == false ->
            {:locale_error, "Locale is not string"}

          is_simple_format(locale) ->
            {:ok, %{code: locale}}

          true ->
            {:locale_error, "Invalid format of locale"}
        end
      end

      defp detect_json_locale_by_filename(file, error_value) do
        locale_from_file = get_locale_from_filename(file)
        cond do
          is_simple_format(locale_from_file) ->
            {:ok, %{code: locale_from_file}}

          true ->
            {:error, error_value}
        end
      end

      defp get_locale_from_filename(file) do
        file |> String.split("/") |> Enum.at(-1) |> String.split(".") |> Enum.at(0)
      end
    end
  end
end
