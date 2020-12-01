defmodule GraphqlRbacExample.Schema do
  use Absinthe.Schema

  use AshGraphql, apis: [GraphqlRbacExample.Accounts.Api, GraphqlRbacExample.Content.Api]

  query do
  end

  mutation do
  end

  def context(ctx) do
    AshGraphql.add_context(ctx, [GraphqlRbacExample.Accounts.Api, GraphqlRbacExample.Content.Api])
  end

  def plugins() do
    [Absinthe.Middleware.Dataloader | Absinthe.Plugin.defaults()]
  end
end
