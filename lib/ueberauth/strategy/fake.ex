# Copyright (c) 2020 Sebastien Braun
#
# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.

defmodule Ueberauth.Strategy.Fake do
  @moduledoc "README.md" |> File.read!() |> String.split("<!-- MDOC -->") |> Enum.fetch!(1)

  use Ueberauth.Strategy
  alias Ueberauth.Failure.Error

  def handle_request!(%{params: %{"user" => user}} = conn) do
    conn
    |> put_resp_cookie("ueberauth_fake_user", user)
    |> redirect!(callback_url(conn))
  end

  def handle_request!(%{cookies: %Plug.Conn.Unfetched{}} = conn) do
    conn
    |> fetch_cookies()
    |> handle_request!
  end

  def handle_request!(%{cookies: %{"ueberauth_fake_user" => _user}} = conn) do
    redirect!(conn, callback_url(conn))
  end

  def handle_request!(conn) do
    conn
  end

  def handle_callback!(%{cookies: %Plug.Conn.Unfetched{}} = conn) do
    conn
    |> fetch_cookies()
    |> put_private(:ueberauth_fake_original_conn, conn)
    |> handle_callback!()
  end

  def handle_callback!(%{cookies: %{"ueberauth_fake_user" => user}} = conn) do
    original_conn = conn.private[:ueberauth_fake_original_conn] || conn

    user_db =
      conn
      |> options
      |> Keyword.fetch!(:user_db)

    user_db_entry = user_db.lookup_user(user)

    handle_user_db_entry(original_conn, user, user_db_entry)
  end

  defp handle_user_db_entry(conn, _user, %Error{} = error) do
    conn
    |> set_errors!(error)
  end

  defp handle_user_db_entry(conn, user, user_db_entry) do
    conn
    |> put_private(:ueberauth_fake_user, user)
    |> put_private(:ueberauth_fake_auth, user_db_entry)
  end

  def uid(conn) do
    conn.private.ueberauth_fake_user
  end

  def info(conn) do
    conn.private.ueberauth_fake_auth.info
  end

  def extra(conn) do
    conn.private.ueberauth_fake_auth[:extra]
  end
end
