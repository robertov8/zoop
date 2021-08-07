defmodule Zoop.MixProject do
  use Mix.Project

  def project do
    [
      app: :zoop,
      version: "0.1.0",
      elixir: "~> 1.12",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      docs: docs(),
      aliases: aliases(),
      test_coverage: [tool: ExCoveralls],
      preferred_cli_env: [
        coveralls: :test,
        "coveralls.detail": :test,
        "coveralls.post": :test,
        "coveralls.html": :test
      ],
      # Docs
      name: "Zoop"
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:ex_doc, "~> 0.24", only: :dev, runtime: false},
      {:excoveralls, "~> 0.10", only: :test},
      {:tesla, "~> 1.4"},
      {:hackney, "~> 1.17.0"},
      {:jason, ">= 1.0.0"}
    ]
  end

  defp docs do
    [
      main: "Zoop",
      groups_for_modules: [
        Structs: [
          Zoop.Buyers,
          Zoop.Ticket,
          Zoop.CreditCard,
          Zoop.CreditCard.Source,
          Zoop.CreditCard.Source.Card
        ],
        MarketPlace: [
          Zoop.MarketPlace.Buyers
        ],
        Payment: [
          Zoop.Payment.CreditCard,
          Zoop.Payment.Ticket
        ]
      ]
    ]
  end

  defp aliases do
    [
      "test.html": ["coveralls.html"]
    ]
  end
end
