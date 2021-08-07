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
      {:tesla, "~> 1.4"},
      {:hackney, "~> 1.17.0"},
      {:jason, ">= 1.0.0"}
    ]
  end

  def docs do
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
end
