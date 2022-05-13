defmodule ChosenApi.Release do
  @app :chosen_api

  require Logger

  def migrate do
    for repo <- repos() do
      {:ok, _, _} = Ecto.Migrator.with_repo(repo, &Ecto.Migrator.run(&1, :up, all: true))
    end
  end

  def rollback(repo, version) do
    {:ok, _, _} = Ecto.Migrator.with_repo(repo, &Ecto.Migrator.run(&1, :down, to: version))
  end

  @spec all_migrations_applied?() :: boolean()
  def all_migrations_applied?() do
    migrations = Ecto.Migrator.migrations(
      ChosenApi.Repo,
      [Ecto.Migrator.migrations_path(ChosenApi.Repo)]
    )

    all_fun = fn
      ({:up, _, _}) ->
        true
      ({:down, timestamp, name}) ->
        Logger.warn("Migration Not Applied: #{timestamp}_#{name}")
        false
    end

    Enum.all?(migrations, all_fun)
  end

  defp repos do
    Application.load(@app)
    Application.fetch_env!(@app, :ecto_repos)
  end
end

