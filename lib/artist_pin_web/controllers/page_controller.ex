defmodule ArtistPinWeb.PageController do
  use ArtistPinWeb, :controller

  def home(conn, _params) do
    render(conn, :home)
  end

  def landing(conn, _params) do
    render(conn, :landing)
  end
end
