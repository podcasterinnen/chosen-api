# ChosenApi

## Requirements

  * Install Erlang, [Elixir](https://elixir-lang.org/install.html),Postgres, the Hex Package Manager, and the Phoenix Mix archive, if it is not already installed on your system.

  ``` bash
  $ brew update
  $ brew install elixir
  $ brew install postgres
  $ mix local.hex
  $ mix archive.install https://github.com/phoenixframework/archives/raw/master/phx_new.ez
  ```

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.create && mix ecto.migrate`
  * Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](http://www.phoenixframework.org/docs/deployment).

## Learn more

  * Official website: http://www.phoenixframework.org/
  * Guides: http://phoenixframework.org/docs/overview
  * Docs: https://hexdocs.pm/phoenix
  * Mailing list: http://groups.google.com/group/phoenix-talk
  * Source: https://github.com/phoenixframework/phoenix
