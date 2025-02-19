defmodule APIRequest.MixProject do
  use Mix.Project

  def project do
    [
      app: :APIRequest,
      version: "0.1.0",
      elixir: "~> 1.13",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      atomvm: [
        start: APIRequest,
        flash_offset: 0x250000
      ]
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
      {:exatomvm, git: "https://github.com/atomvm/ExAtomVM/"}
    ]
  end
end
