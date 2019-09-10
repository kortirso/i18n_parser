defmodule I18nParser.Detect.Json do
  @moduledoc """
  Module for detecting locale of the Json files
  """

  defmacro __using__(_opts) do
    quote do
      # detect json locale by inner content
      defp do_detect_json(file, %{data_with_locale: true}) do
        with {:ok, body} <- File.read(file),
             {:ok, json} <- Poison.decode(body) do
               detect_json_locale(json)
        else
          _ -> {:error, "File reading error"}
        end
      end

      # detect json locale by short file name
      defp do_detect_json(_, %{data_with_locale: false, filename: filename}) when is_binary(filename) do
        filename
        |> get_locale_from_string()
        |> do_detect_json()
      end

      # detect json locale by long file name
      defp do_detect_json(file, %{data_with_locale: false, filename: nil}) do
        file
        |> get_locale_from_filename()
        |> do_detect_json()
      end

      # check locale
      defp do_detect_json(value) when is_binary(value) do
        cond do
          is_simple_format(value) ->
            {:ok, %{code: value}}

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
        file |> String.split("/") |> Enum.at(-1) |> get_locale_from_string()
      end

      defp get_locale_from_string(value) do
        value |> String.split(".") |> Enum.at(0)
      end
    end
  end
end
