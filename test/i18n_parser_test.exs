defmodule I18nParserTest do
  use ExUnit.Case

  test "returns error for unexisted file" do
    file = File.cwd! |> Path.join("test/fixtures/something.yml")

    assert {:error, "File is not available"} = file |> I18nParser.detect("yml")
  end

  describe "YML I18nParser" do
    test "detects locale" do
      file = File.cwd! |> Path.join("test/fixtures/en.yml")

      assert {:ok, %{code: "en"}} = file |> I18nParser.detect("yml")
    end

    test "returns error for unsupported extension" do
      file = File.cwd! |> Path.join("test/fixtures/en.yml")

      assert {:error, "Unsupported file format"} = file |> I18nParser.detect("")
    end

    test "returns error for invalid file" do
      file = File.cwd! |> Path.join("test/fixtures/invalid.yml")

      assert {:error, "Invalid amount of keys"} = file |> I18nParser.detect("yml")
    end

    test "returns error for invalid locale format" do
      file = File.cwd! |> Path.join("test/fixtures/invalid_format.yml")

      assert {:error, "Invalid format of locale"} = file |> I18nParser.detect("yml")
    end

    test "returns error for not yml file" do
      file = File.cwd! |> Path.join("test/fixtures/strings.xml")

      assert {:error, "YML structure error"} = file |> I18nParser.detect("yml")
    end

    test "returns error if locale is not string" do
      file = File.cwd! |> Path.join("test/fixtures/locale_is_not_string.yml")

      assert {:error, "Locale is not string"} = file |> I18nParser.detect("yml")
    end
  end

  describe "YML detection" do
    test "detects locale" do
      file = File.cwd! |> Path.join("test/fixtures/en.yml")

      assert {:ok, converted_data, sentences} = file |> I18nParser.convert("yml")
      assert %{} = converted_data
    end

    test "returns error for unsupported extension" do
      file = File.cwd! |> Path.join("test/fixtures/en.yml")

      assert {:error, "Unsupported file format"} = file |> I18nParser.convert("")
    end
  end
end
