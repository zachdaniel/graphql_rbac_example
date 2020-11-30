# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :graphql_rbac_example,
  ecto_repos: [GraphqlRbacExample.Repo]

# Configures the endpoint
config :graphql_rbac_example, GraphqlRbacExampleWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "BqcJL7Mc4EyqHTpeO+4nlbcQxUZgoBnpv+IhAUiWZBhJ2GoUtGMY212dIpeJ0sF5",
  render_errors: [view: GraphqlRbacExampleWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: GraphqlRbacExample.PubSub,
  live_view: [signing_salt: "7QpQ5gzS"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
