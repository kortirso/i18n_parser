defmodule I18nParser.DetectionTest do
  use ExUnit.Case

  alias I18nParser.Detection

  test "creates new detector" do
    path = File.cwd! |> Path.join("test/fixtures/en.yml")
    assert %Detection{file: file} = Detection.new(path)

    assert file == path
  end
end
