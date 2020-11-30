defmodule GraphqlRbacExample.Repo do
  use Ecto.Repo,
    otp_app: :graphql_rbac_example,
    adapter: Ecto.Adapters.Postgres
end
