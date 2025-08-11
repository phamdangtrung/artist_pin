# This file is responsible for configuring your application
# and its dependencies with the aid of the Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

config :artist_pin, :scopes,
  user: [
    default: true,
    module: ArtistPin.Users.Scope,
    assign_key: :current_scope,
    access_path: [:user, :id],
    schema_key: :user_id,
    schema_type: :id,
    schema_table: :users,
    test_data_fixture: ArtistPin.UsersFixtures,
    test_setup_helper: :register_and_log_in_user
  ]

config :artist_pin,
  ecto_repos: [ArtistPin.AuthRepo],
  generators: [timestamp_type: :utc_datetime]

config :artist_pin,
  ecto_repos: [ArtistPin.AppRepo],
  generators: [timestamp_type: :utc_datetime]

# Configures the endpoint
config :artist_pin, ArtistPinWeb.Endpoint,
  # url: [host: "localhost", port: 0],
  http: [ip: {127, 0, 0, 1}, port: 10_000 + :rand.uniform(45_000)],
  server: true,
  adapter: Bandit.PhoenixAdapter,
  render_errors: [
    formats: [html: ArtistPinWeb.ErrorHTML, json: ArtistPinWeb.ErrorJSON],
    layout: false
  ],
  pubsub_server: ArtistPin.PubSub,
  live_view: [signing_salt: "JeOBo8NE"]

# Configures the mailer
#
# By default it uses the "Local" adapter which stores the emails
# locally. You can see the emails in your browser, at "/dev/mailbox".
#
# For production it's recommended to configure a different adapter
# at the `config/runtime.exs`.
config :artist_pin, ArtistPin.Mailer, adapter: Swoosh.Adapters.Local

# Configure esbuild (the version is required)
config :esbuild,
  version: "0.25.4",
  artist_pin: [
    args:
      ~w(js/app.js --bundle --target=es2022 --outdir=../priv/static/assets/js --external:/fonts/* --external:/images/* --alias:@=.),
    cd: Path.expand("../assets", __DIR__),
    env: %{"NODE_PATH" => [Path.expand("../deps", __DIR__), Mix.Project.build_path()]}
  ]

# Configure tailwind (the version is required)
config :tailwind,
  version: "4.1.7",
  artist_pin: [
    args: ~w(
      --input=assets/css/app.css
      --output=priv/static/assets/css/app.css
    ),
    cd: Path.expand("..", __DIR__)
  ]

# Configures Elixir's Logger
config :logger, :default_formatter,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"
