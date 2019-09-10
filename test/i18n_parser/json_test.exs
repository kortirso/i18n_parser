defmodule JsonTest do
  use ExUnit.Case

  test "json, returns error for unexisted file" do
    file = File.cwd! |> Path.join("test/fixtures/something.json")

    assert {:error, "File reading error"} = file |> I18nParser.detect("json", %{by_content: true})
  end

  describe "JSON detection" do
    test "detects locale by inner content" do
      file = File.cwd! |> Path.join("test/fixtures/data.json")

      assert {:ok, %{code: "ru"}} = file |> I18nParser.detect("json", %{by_content: true})
    end

    test "detects locale by file name" do
      file = File.cwd! |> Path.join("test/fixtures/de.json")

      assert {:ok, %{code: "de"}} = file |> I18nParser.detect("json", %{by_content: false})
    end

    test "returns error for unsupported extension" do
      file = File.cwd! |> Path.join("test/fixtures/data.json")

      assert {:error, "Unsupported file format"} = file |> I18nParser.detect("", %{by_content: true})
    end

    test "returns error for invalid amount of keys" do
      file = File.cwd! |> Path.join("test/fixtures/data_invalid.json")

      assert {:error, "Invalid amount of keys"} = file |> I18nParser.detect("json", %{by_content: true})
    end
  end
end
