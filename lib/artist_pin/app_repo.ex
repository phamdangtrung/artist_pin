defmodule ArtistPin.AppRepo do
  use Ecto.Repo,
    otp_app: :artist_pin,
    adapter: Ecto.Adapters.SQLite3
end
