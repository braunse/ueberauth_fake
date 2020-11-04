# Copyright (c) 2020 Sebastien Braun
#
# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.

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
