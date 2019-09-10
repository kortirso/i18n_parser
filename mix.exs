defmodule I18nParser.MixProject do
  use Mix.Project

  @description """
    Parsing I18n files for different frameworks
  """

  def project do
    [
      app: :i18n_parser,
      version: "0.1.10",
      elixir: "~> 1.7",
      name: "I18nParser",
      description: @description,
      source_url: "https://github.com/kortirso/i18n_parser",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      package: package()
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp deps do
    [
      {:ex_doc, "~> 0.19", only: :dev},
      # working with yml files
      {:yml, "0.9.1"},
      # working with json files
      {:poison, "~> 3.1"}
    ]
  end

  defp package do
    [
      maintainers: ["Anton Bogdanov"],
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/kortirso/i18n_parser"}
    ]
  end
end
