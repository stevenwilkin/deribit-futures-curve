# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

# Configures the endpoint
config :deribit, DeribitWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "b4bEKx222i15Ui85XgkAuz8js0KWH9x36lSg/Fejjo4R0PL6Lpj2v3asJGmsHB9/",
  render_errors: [view: DeribitWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: Deribit.PubSub,
  live_view: [signing_salt: "jT1Vr2gG"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
