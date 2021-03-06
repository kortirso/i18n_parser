defmodule I18nParser.Detect do
  @moduledoc """
  Module for containing all detecting modules
  """

  alias I18nParser.Detect.{Yml, Json}
  use Yml
  use Json

  def do_detect(file, "yml", _), do: do_detect_yml(file)
  def do_detect(file, "json", options), do: do_detect_json(file, options)
  def do_detect(_, _, _), do: {:error, "Unsupported file format"}

  defp is_simple_format(locale), do: String.length(locale) == 2
end
