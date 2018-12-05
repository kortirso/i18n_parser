defmodule I18nParser.Detection do
  @moduledoc """
  Module for detection locale of the file
  """

  alias I18nParser.Detection

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
end
