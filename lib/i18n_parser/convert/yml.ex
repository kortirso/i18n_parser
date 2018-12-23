defmodule I18nParser.Convert.Yml do
  @moduledoc """
  Module for reading data from YML file
  """

  defmacro __using__(_opts) do
    quote do
      defp do_convert_yml(file) do
        case Yml.read_from_file(file) do
          {:ok, yml} -> extract_data(yml)
          result -> result
        end
      end

      defp extract_data(%{} = yml) do
        yml |> Map.values() |> Enum.at(0) |> convert_data() |> present()
      end

      defp convert_data(map_for_translation, converted_data \\ %{}, sentences \\ []) do
        Enum.reduce(map_for_translation, {converted_data, sentences}, fn {key, value}, {converted_data, sentences} ->
          {converted_value, sentences} = check_value_type(value, sentences)
          # add data to converted_data map
          {
            Map.put(converted_data, key, converted_value),
            sentences
          }
        end)
      end

      # use recursion to find real values for translation
      defp check_value_type(%{} = value, sentences), do: convert_data(value, %{}, sentences)

      # convert value to by template
      # add data to translations list
      defp check_value_type(value, sentences) do
        index = length(sentences)
        {
          "###{index}##",
          [{index, value} | sentences]
        }
      end

      defp present({converted_data, sentences}) do
        {
          :ok,
          converted_data,
          Enum.reverse(sentences)
        }
      end
    end
  end
end
