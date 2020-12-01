defmodule GraphqlRbacExample.Checks.Rbac do
  use AshPolicyAuthorizer.SimpleCheck

  def rbac(resource, type) do
    {__MODULE__, [resource: resource, type: type]}
  end

  def match?(nil, _, _), do: false

  def match?(actor, _context, opts) do
    IO.inspect(actor)

    Enum.any?(actor.roles, fn role ->
      Enum.any?(role.permissions, fn permission ->
        permission.resource == opts[:resource] && permission.type == opts[:type]
      end)
    end)
    |> IO.inspect()
  end
end
