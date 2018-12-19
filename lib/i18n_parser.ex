defmodule I18nParser do
  @moduledoc """
  Module for parsing i18n files
  """

  alias I18nParser.{Detect, Convert}

  use Detect.Yml
  use Convert.Yml

  defstruct file: nil, extension: nil

  @doc """
  Detects locale for the file

  ## Parameters

    - file: path to file for locale detection
    - extension: extension of the file, like "yml"

  ## Examples

      iex> I18nParser.detect("/some_path_to_file", "yml")
      {:ok, %{code: "en"}}

  """
  @spec detect(String.t(), String.t()) :: {:ok, %{code: String.t()}}

  def detect(file, extension) do
    case File.read(file) do
      {:ok, _} -> do_detect(file, extension)
      _ -> {:error, "File is not available"}
    end    
  end

  defp do_detect(file, "yml"), do: do_detect_yml(file)
  defp do_detect(_, _), do: {:error, "Unsupported file format"}

  @doc """
  Convert data from file

  ## Parameters

    - file: path to file for locale detection
    - extension: extension of the file, like "yml"

  ## Examples

      iex> I18nParser.convert("/some_path_to_file", "yml")
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
      {:ok, _} -> do_convert(file, extension)
      _ -> {:error, "File is not available"}
    end
  end

  defp do_convert(file, "yml"), do: do_convert_yml(file)
  defp do_convert(_, _), do: {:error, "Unsupported file format"}
end
