defmodule UeberauthFake.MixProject do
  use Mix.Project

  def project do
    [
      app: :ueberauth_fake,
      source_url: "https://github.com/braunse/ueberauth_fake",
      version: "0.1.0",
      elixir: "~> 1.11",
      start_permanent: Mix.env() == :prod,
      elixirc_paths: elixirc_paths(Mix.env()),
      deps: deps(),
      docs: [
        main: "Ueberauth.Strategy.Fake"
      ]
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:ueberauth, "~> 0.6.3"},
      {:credo, "~> 1.5.0", runtime: false, only: [:dev]},
      {:ex_doc, "~> 0.23.0", runtime: false, only: [:dev]}
    ]
  end
end
