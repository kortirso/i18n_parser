defmodule I18nParser.DetectionTest do
  use ExUnit.Case

  alias I18nParser.Detection

  setup_all do
    file = File.cwd! |> Path.join("test/fixtures/en.yml")
    {:ok, file: file, extension: "yml"}
  end

  test "detect locale", state do
    assert {:ok, %{code: "en"}} = state[:file] |> Detection.detect(state[:extension])
  end

  test "detect locale, for invalid file" do
    file = File.cwd! |> Path.join("test/fixtures/invalid.yml")

    assert {:error, "Invalid amount of keys"} = file |> Detection.detect("yml")
  end
end
