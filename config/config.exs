# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
import Config

# General application configuration
config :chosen_api,
  ecto_repos: [ChosenApi.Repo]

config :chosen_api, ChosenApi.Mailer,
  relay: "mail11.web-server.biz",
  hostname: "podcasterinnen.org"

# Configures the endpoint
config :chosen_api, ChosenApiWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "qL/sfpfX8ijaOyWxYGIANz8v6fvMUgDmBgp1rkGtkI1Uf9rtl+JyPxZNcxGBDU2B",
  render_errors: [view: ChosenApiWeb.ErrorView, accepts: ~w(json)],
  pubsub: [name: ChosenApi.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Phauxth authentication configuration
config :phauxth,
  endpoint: ChosenApiWeb.Endpoint,
  token_salt: "iYSQOB3i"

# Mailer configuration
config :chosen_api, ChosenApi.Mailer,
  adapter: Swoosh.Adapters.SMTP,
  port: 587,
  tls: :always,
  allowed_tls_versions: [:tlsv1, :"tlsv1.1", :"tlsv1.2"], # or {":system", ALLOWED_TLS_VERSIONS"} w/ comma seprated values (e.g. "tlsv1.1,tlsv1.2")
  ssl: false, # can be `true`
  retries: 1,
  no_mx_lookups: false, # can be `true`
  auth: :if_available # can be `always`. If your smtp relay requires authentication set it to `always`.

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :phoenix, :json_library, Jason

config :esbuild, :version, "0.14.0"

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
