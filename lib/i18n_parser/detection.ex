defmodule I18nParser.Detection do
  @moduledoc """
  Module for detecting locale of the file
  """

  alias I18nParser.Detection

  use Detection.Yml

  defstruct file: nil, extension: nil

  @doc """
  Detects locale for the file

  ## Parameters

    - file: path to file for locale detection
    - extension: extension of the file, like "yml"

  ## Examples

      iex> I18nParser.Detection.detect("/some_path_to_file", "yml")
      {:ok, %{code: "en"}}

  """
  @spec detect(String.t(), String.t()) :: {:ok, %{code: String.t()}}

  def detect(file, extension) do
    case File.read(file) do
      {:ok, _} -> process_file(file, extension)
      _ -> {:error, "File is not available"}
    end    
  end

  defp process_file(file, "yml"), do: process_yml_file(file)
  defp process_file(_, _), do: {:error, "Unsupported file format"}
end
