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
    end
  end
end
