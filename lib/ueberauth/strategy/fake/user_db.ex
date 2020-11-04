defmodule Ueberauth.Strategy.Fake.UserDB do
  @moduledoc """
  A behaviour for a fake "User Database". This needs to be implemented to
  use the `Ueberauth.Strategy.Fake` strategy. The `c:lookup_user/1` callback
  will be called with the supplied user ID to determine what data should
  be returned by the authentication.
  """

  alias Ueberauth.Failure.Error

  @type user_entry ::
          %{
            :info => Ueberauth.Auth.Info.t(),
            optional(:extra) => Ueberauth.Auth.Extra.t()
          }

  @doc """
  Look up the data to be returned from the authentication attempt.

  ### Returns:

  Either a `Ueberauth.Failure.Error` to fail the authentication
  attempt, or a map of the form

  ```elixir
  %{
    info:
      %Ueberauth.Auth.Info{
        # ...
      },

    # optional
    extra:
      %Ueberauth.Auth.Extra{
        # ...
      }
  }
  ```
  """
  @callback lookup_user(user :: String.t()) :: user_entry() | Error.t()
end
