defmodule ShopExWeb.PageLiveTest do
  use ShopExWeb.ConnCase

  import Phoenix.LiveViewTest

  test "disconnected and connected render", %{conn: conn} do
    {:ok, page_live, disconnected_html} = live(conn, "/")
    assert disconnected_html =~ "Welcome to ShopEx!"
    assert render(page_live) =~ "Welcome to ShopEx!"
  end
end
