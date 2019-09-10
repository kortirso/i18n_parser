defmodule I18nParser.Convert do
  @moduledoc """
  Module for containing all converting modules
  """

  alias I18nParser.Convert.{Yml, Json}
  use Yml
  use Json

  def do_convert(file, "yml", _), do: do_convert_yml(file)
  def do_convert(file, "json", _), do: do_convert_json(file)
  def do_convert(_, _, _), do: {:error, "Unsupported file format"}
end
