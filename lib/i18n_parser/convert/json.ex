defmodule I18nParser.Convert.Json do
  @moduledoc """
  Module for reading data from Json file
  """

  defmacro __using__(_opts) do
    quote do
      defp do_convert_json(file, data_with_locale) do
        with {:ok, body} <- File.read(file),
             {:ok, json} <- Poison.decode(body) do
               extract_data(json, data_with_locale)
        else
          _ -> {:error, "File reading error"}
        end
      end

      # json contains data with locale
      defp extract_data(%{} = json, true) do
        json |> Map.values() |> Enum.at(0) |> extract_data(false)
      end

      # json contains only data
      defp extract_data(%{} = json, false) do
        json |> convert_data() |> present()
      end
    end
  end
end
