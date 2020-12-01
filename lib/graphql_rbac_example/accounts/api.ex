defmodule GraphqlRbacExample.Accounts.Api do
  use Ash.Api,
    extensions: [AshGraphql.Api]

  alias GraphqlRbacExample.Accounts.{UserRole, User, Role, Permission}

  resources do
    resource User
    resource Role
    resource UserRole
    resource Permission
  end
end
