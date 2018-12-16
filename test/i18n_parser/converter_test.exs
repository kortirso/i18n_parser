defmodule I18nParser.ConverterTest do
  use ExUnit.Case

  alias I18nParser.Converter

  test "returns error for unexisted file" do
    file = File.cwd! |> Path.join("test/fixtures/something.yml")

    assert {:error, "File is not available"} = file |> Converter.convert("yml")
  end

  describe "YML detection" do
    test "detects locale" do
      file = File.cwd! |> Path.join("test/fixtures/en.yml")

      assert {:ok, converted_data, sentences} = file |> Converter.convert("yml")
      assert %{} = converted_data
    end

    test "returns error for unsupported extension" do
      file = File.cwd! |> Path.join("test/fixtures/en.yml")

      assert {:error, "Unsupported file format"} = file |> Converter.convert("")
    end
  end
end
