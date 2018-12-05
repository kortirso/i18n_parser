defmodule I18nParser.DetectionTest do
  use ExUnit.Case

  alias I18nParser.Detection

  setup_all do
    path = File.cwd! |> Path.join("test/fixtures/en.yml")
    {:ok, detector: Detection.new(path)}
  end

  test "creates new detector", state do
    assert %Detection{file: file} = state[:detector]
    assert file != nil
  end

  test "detect locale", state do
    assert {:ok, %{code: "en"}} = state[:detector] |> Detection.detect()
  end

  test "detect locale, for invalid file" do
    path = File.cwd! |> Path.join("test/fixtures/invalid.yml")

    assert {:error, "Invalid format of locale"} = Detection.new(path) |> Detection.detect()
  end
end
