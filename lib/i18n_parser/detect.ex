defmodule I18nParser.Detect do
  @moduledoc """
  Module for containing all detecting modules
  """

  alias I18nParser.Detect.{Yml, Json}
  use Yml
  use Json

  def do_detect(file, "yml"), do: do_detect_yml(file)
  def do_detect(file, "json"), do: do_detect_json(file)
  def do_detect(_, _), do: {:error, "Unsupported file format"}
end
