defmodule I18nParser.Converter do
  @moduledoc """
  Module for converting data from file
  """

  alias I18nParser.Converter

  use Converter.Yml

  defstruct file: nil, extension: nil

  @doc """
  Convert data from file

  ## Parameters

    - file: path to file for locale detection
    - extension: extension of the file, like "yml"

  ## Examples

      iex> I18nParser.Converter.convert("/some_path_to_file", "yml")
      {
        :ok,
        %{
          "buttons" => %{"click" => "##0##"},
          "welcome" => %{"index" => %{"first" => "##1##", "last" => "##2##"}}
        },
        [{0, "Click me!"}, {1, "Hello"}, {2, "Buy"}]
      }

  """
  @spec convert(String.t(), String.t()) :: {:ok, %{}}

  def convert(file, extension) do
    case File.read(file) do
      {:ok, _} -> process_file(file, extension)
      _ -> {:error, "File is not available"}
    end    
  end

  defp process_file(file, "yml"), do: process_yml_file(file)
  defp process_file(_, _), do: {:error, "Unsupported file format"}
end
