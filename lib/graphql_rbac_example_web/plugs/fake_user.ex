defmodule GraphqlRbacExample.Plugs.FakeUser do
  require Ash.Query

  def init(opts) do
    opts
  end

  def call(conn, _opts) do
    case Plug.Conn.get_req_header(conn, "role") do
      ["admin"] ->
        id = "6ac84c7b-144a-47ef-a342-57d18b814469"

        actor =
          GraphqlRbacExample.Accounts.User
          |> Ash.Query.load(roles: :permissions)
          |> Ash.Query.filter(id == ^id)
          |> GraphqlRbacExample.Accounts.Api.read_one!()

        conn
        |> Absinthe.Plug.put_options(context: %{actor: actor})

      ["member"] ->
        id = "d58fecc4-ea1c-4019-a498-b4d8297d7c87"

        actor =
          GraphqlRbacExample.Accounts.User
          |> Ash.Query.load(roles: :permissions)
          |> Ash.Query.filter(id == ^id)
          |> GraphqlRbacExample.Accounts.Api.read_one!()

        conn
        |> Absinthe.Plug.put_options(context: %{actor: actor})

      [] ->
        conn
        |> Absinthe.Plug.put_options(context: %{actor: nil})
    end
  end
end
