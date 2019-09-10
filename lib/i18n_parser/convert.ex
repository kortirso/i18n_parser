defmodule I18nParser.Convert do
  @moduledoc """
  Module for containing all converting modules
  """

  alias I18nParser.Convert.{Yml}
  use Yml

  def do_convert(file, "yml"), do: do_convert_yml(file)
  def do_convert(_, _), do: {:error, "Unsupported file format"}
end
