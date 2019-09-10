defmodule I18nParser do
  @moduledoc """
  Module for parsing i18n files
  """

  import I18nParser.{Detect, Convert}

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

  def detect(file, extension), do: do_detect(file, extension)

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

  def convert(file, extension), do: do_convert(file, extension)
end
