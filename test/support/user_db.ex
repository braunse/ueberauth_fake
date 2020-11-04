defmodule Ueberauth.Strategy.Fake.TestUserDB do
  @moduledoc false

  @behaviour Ueberauth.Strategy.Fake.UserDB

  def lookup_user("user"),
    do: %{
      info: %Ueberauth.Auth.Info{
        email: "user@example.com",
        name: "User McUser"
      }
    }
end
