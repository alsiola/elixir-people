defmodule People.Repo do
  use Ecto.Repo,
    otp_app: :people,
    adapter: Ecto.Adapters.Postgres
end
