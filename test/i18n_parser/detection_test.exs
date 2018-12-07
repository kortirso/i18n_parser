defmodule I18nParser.DetectionTest do
  use ExUnit.Case

  alias I18nParser.Detection

  test "returns error for unexisted file" do
    file = File.cwd! |> Path.join("test/fixtures/something.yml")

    assert {:error, "File is not available"} = file |> Detection.detect("yml")
  end

  describe "YML detection" do
    test "detects locale" do
      file = File.cwd! |> Path.join("test/fixtures/en.yml")

      assert {:ok, %{code: "en"}} = file |> Detection.detect("yml")
    end

    test "returns error for unsupported extension" do
      file = File.cwd! |> Path.join("test/fixtures/en.yml")

      assert {:error, "Unsupported file format"} = file |> Detection.detect("")
    end

    test "returns error for invalid file" do
      file = File.cwd! |> Path.join("test/fixtures/invalid.yml")

      assert {:error, "Invalid amount of keys"} = file |> Detection.detect("yml")
    end

    test "returns error for invalid locale format" do
      file = File.cwd! |> Path.join("test/fixtures/invalid_format.yml")

      assert {:error, "Invalid format of locale"} = file |> Detection.detect("yml")
    end

    test "returns error for not yml file" do
      file = File.cwd! |> Path.join("test/fixtures/strings.xml")

      assert {:error, "YML structure error"} = file |> Detection.detect("yml")
    end

    test "returns error if locale is not string" do
      file = File.cwd! |> Path.join("test/fixtures/locale_is_not_string.yml")

      assert {:error, "Locale is not string"} = file |> Detection.detect("yml")
    end
  end
end
