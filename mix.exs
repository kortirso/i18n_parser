defmodule I18nParser.MixProject do
  use Mix.Project

  @description """
    Parsing I18n files for different frameworks
  """

  def project do
    [
      app: :i18n_parser,
      version: "0.1.2",
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
      {:yaml_elixir, "~> 2.1.0"}
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
