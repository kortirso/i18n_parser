defmodule I18nParser.Detect.Json do
  @moduledoc """
  Module for detecting locale of the Json files
  """

  defmacro __using__(_opts) do
    quote do
      # detect json locale by inner content
      defp do_detect_json(file, true) do
        with {:ok, body} <- File.read(file),
             {:ok, json} <- Poison.decode(body) do
               detect_json_locale(json)
        else
          _ -> {:error, "File reading error"}
        end
      end

      # detect json locale by file name
      defp do_detect_json(file, false) do
        locale_from_file = get_locale_from_filename(file)
        cond do
          is_simple_format(locale_from_file) ->
            {:ok, %{code: locale_from_file}}

          true ->
            {:error, "File name does not contain locale"}
        end
      end

      defp detect_json_locale(%{} = json) do
        keys = Map.keys(json)
        locale = Enum.at(keys, 0)
        cond do
          length(keys) != 1 ->
            {:error, "Invalid amount of keys"}

          is_binary(locale) == false ->
            {:error, "Locale is not string"}

          is_simple_format(locale) ->
            {:ok, %{code: locale}}

          true ->
            {:error, "Invalid format of locale"}
        end
      end

      defp get_locale_from_filename(file) do
        file |> String.split("/") |> Enum.at(-1) |> String.split(".") |> Enum.at(0)
      end
    end
  end
end
