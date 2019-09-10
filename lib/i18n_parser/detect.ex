defmodule I18nParser.Detect do
  @moduledoc """
  Module for containing all detecting modules
  """

  alias I18nParser.Detect.{Yml, Json}
  use Yml
  use Json

  def do_detect(file, "yml", _), do: do_detect_yml(file)
  def do_detect(file, "json", %{by_content: by_content}), do: do_detect_json(file, by_content)
  def do_detect(_, _, _), do: {:error, "Unsupported file format"}
end
