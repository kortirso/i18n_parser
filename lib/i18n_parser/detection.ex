defmodule I18nParser.Detection do
  @moduledoc """
  Module for detection locale of the file
  """

  alias I18nParser.Detection

  use Detection.Extensions

  defstruct file: nil, extension: nil

  @doc """
  Detects locale for the file

  ## Parameters

    - file: path to file for locale detection
    - extension: extension of the file

  ## Examples

      iex> I18nParser.Detection.detect("/some_path_to_file", "yml")
      {:ok, %{code: "en"}}

  """
  @spec detect(String.t(), String.t()) :: {:ok, %{code: String.t()}}

  def detect(file, extension) do
    file
    |> detect_locale(extension)
  end
end
