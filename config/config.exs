import Config

if Mix.env() == :test do
  config :ueberauth, Ueberauth,
    providers: [
      fake:
        {Ueberauth.Strategy.Fake,
         [
           user_db: Ueberauth.Strategy.Fake.TestUserDB
         ]}
    ]
end
