defmodule I18nParser.Convert do
  @moduledoc """
  Module for containing all converting modules
  """

  alias I18nParser.Convert.{Yml, Json}
  use Yml
  use Json

  def do_convert(file, "yml", _), do: do_convert_yml(file)
  def do_convert(file, "json", %{data_with_locale: data_with_locale}), do: do_convert_json(file, data_with_locale)
  def do_convert(_, _, _), do: {:error, "Unsupported file format"}

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
