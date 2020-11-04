defmodule UeberauthFakeTest do
  use ExUnit.Case
  doctest UeberauthFake

  import Plug.Conn
  import Plug.Test

  test "it redirects directly to the callback" do
    routes = Ueberauth.init()

    conn =
      conn(:get, "/auth/fake", user: "fakeuser")
      |> Ueberauth.call(routes)

    assert conn.status == 302
    assert [location] = get_resp_header(conn, "location")

    location = URI.parse(location)
    assert location.path == "/auth/fake/callback"
  end

  test "it succeeds when a user cookie is set" do
    routes = Ueberauth.init()

    conn =
      conn(:get, "/auth/fake/callback")
      |> Plug.Test.put_req_cookie("ueberauth_fake_user", "user")
      |> Ueberauth.call(routes)

    assert %{
             ueberauth_auth: %{
               info: %Ueberauth.Auth.Info{} = info,
               uid: "user"
             }
           } = conn.assigns

    assert %{name: "User McUser", email: "user@example.com"} = info
  end
end
