# ueberauth_fake

<!-- MDOC -->

This is a fake [Ueberauth](https://hexdocs.pm/ueberauth) strategy for
testing purposes. I use it for driving browser-based tests with
[wallaby](https://hexdocs.pm/wallaby) without involving a full identity
provider in my test runs.

## Installation

At the moment, this is not available on Hex, so use a github reference:

```elixir
def deps do
  [
    {:ueberauth_fake, github: "braunse/ueberauth_fake"}
  ]
end
```

## Configuration

Make a user database module to look up information on your fake users.
It has to conform to the `Ueberauth.Strategy.Fake.UserDB` behaviour.

Then, add a fake provider in your config/dev.exs:

```elixir
config :ueberauth, Ueberauth, providers: [
  # ...,
  fake: {Ueberauth.Strategy.Fake, [
    user_db: My.UserDB.Module
  ]}
]
```

And to log in as user `user42`, send the browser to `/auth/fake?user=user42`
