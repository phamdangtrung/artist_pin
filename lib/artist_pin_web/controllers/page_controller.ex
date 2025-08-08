defmodule ArtistPinWeb.PageController do
  use ArtistPinWeb, :controller

  def home(conn, _params) do
    render(conn, :home)
  end
end
