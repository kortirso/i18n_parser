defmodule I18nParser.Detection do
  @moduledoc """
  Module for detection locale of the file
  """

  alias I18nParser.Detection

  use Detection.Extensions

  defstruct file: nil

  @doc """
  Creates detector

  ## Parameters

    - file: path to file for locale detection

  ## Examples

      iex> detector = "/en.yml" |> I18nParser.Detection.new()
      %I18nParser.Detection{file: "/en.yml"}

  """
  @spec new(String.t()) :: %Detection{file: String.t()}

  def new(file) do
    %Detection{file: file}
  end

  @doc """
  Detects locale

  ## Examples

      iex> detector |> I18nParser.Detection.detect()
      {:ok, %{code: "en"}}

  """
  @spec detect(%Detection{file: String.t()}) :: {:ok, %{code: String.t(), name: String.t()}}

  def detect(%Detection{file: file}) do
    file
    |> String.split(".")
    |> Enum.at(-1)
    |> detect_locale(file)
  end
end
