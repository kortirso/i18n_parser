defmodule JsonTest do
  use ExUnit.Case

  test "json, returns error for unexisted file" do
    file = File.cwd! |> Path.join("test/fixtures/something.json")

    assert {:error, "File reading error"} = file |> I18nParser.detect("json", %{data_with_locale: true})
  end

  describe "JSON detection" do
    test "detects locale by inner content" do
      file = File.cwd! |> Path.join("test/fixtures/data.json")

      assert {:ok, %{code: "ru"}} = file |> I18nParser.detect("json", %{data_with_locale: true})
    end

    test "detects locale by file name" do
      file = File.cwd! |> Path.join("test/fixtures/de.json")

      assert {:ok, %{code: "de"}} = file |> I18nParser.detect("json", %{data_with_locale: false})
    end

    test "returns error for unsupported extension" do
      file = File.cwd! |> Path.join("test/fixtures/data.json")

      assert {:error, "Unsupported file format"} = file |> I18nParser.detect("", %{data_with_locale: true})
    end

    test "returns error for invalid amount of keys" do
      file = File.cwd! |> Path.join("test/fixtures/data_invalid.json")

      assert {:error, "Invalid amount of keys"} = file |> I18nParser.detect("json", %{data_with_locale: true})
    end
  end

  describe "JSON converting" do
    test "converts data" do
      file = File.cwd! |> Path.join("test/fixtures/de.json")

      assert {:ok, converted_data, sentences} = file |> I18nParser.convert("json", %{data_with_locale: false})
      assert %{} = converted_data
    end

    test "returns error for unsupported extension" do
      file = File.cwd! |> Path.join("test/fixtures/de.json")

      assert {:error, "Unsupported file format"} = file |> I18nParser.convert("")
    end
  end
end
