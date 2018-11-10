defmodule People.Application do
  @moduledoc false

  use Application

  def start(_type, _args) do
    # List all child processes to be supervised
    children = [
      # Start the Ecto repository
      People.Repo,
      # Start the endpoint when the application starts
      PeopleWeb.Endpoint
    ]

    opts = [strategy: :one_for_one, name: People.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    PeopleWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
