defmodule GraphqlRbacExample.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      GraphqlRbacExample.Repo,
      # Start the Telemetry supervisor
      GraphqlRbacExampleWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: GraphqlRbacExample.PubSub},
      # Start the Endpoint (http/https)
      GraphqlRbacExampleWeb.Endpoint
      # Start a worker by calling: GraphqlRbacExample.Worker.start_link(arg)
      # {GraphqlRbacExample.Worker, arg}
    ]

    member =
      GraphqlRbacExample.Accounts.Role
      |> Ash.Changeset.new(%{name: "member"})
      |> GraphqlRbacExample.Accounts.Api.create!()

    admin =
      GraphqlRbacExample.Accounts.Role
      |> Ash.Changeset.new(%{name: "admin"})
      |> GraphqlRbacExample.Accounts.Api.create!()

    # members can read users
    GraphqlRbacExample.Accounts.Permission
    |> Ash.Changeset.new(%{type: :query, resource: :user})
    |> Ash.Changeset.replace_relationship(:role, member)
    |> GraphqlRbacExample.Accounts.Api.create!()

    for type <- [:query, :insert, :update, :delete] do
      GraphqlRbacExample.Accounts.Permission
      |> Ash.Changeset.new(%{type: type, resource: :user})
      |> Ash.Changeset.replace_relationship(:role, admin)
      |> GraphqlRbacExample.Accounts.Api.create!()
    end

    # admin
    GraphqlRbacExample.Accounts.User
    |> Ash.Changeset.new(%{
      "username" => "admin",
      "id" => "6ac84c7b-144a-47ef-a342-57d18b814469"
    })
    |> Ash.Changeset.replace_relationship(:roles, [admin])
    |> GraphqlRbacExample.Accounts.Api.create!()

    # member
    GraphqlRbacExample.Accounts.User
    |> Ash.Changeset.new(%{
      "username" => "member",
      "id" => "d58fecc4-ea1c-4019-a498-b4d8297d7c87"
    })
    |> Ash.Changeset.replace_relationship(:roles, [member])
    |> GraphqlRbacExample.Accounts.Api.create!()

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: GraphqlRbacExample.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    GraphqlRbacExampleWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
