defmodule GraphqlRbacExample.Accounts.UserRole do
  use Ash.Resource,
    data_layer: Ash.DataLayer.Ets

  actions do
    create :create
    read :read
    update :update
    destroy :destroy
  end

  attributes do
    uuid_primary_key :id
  end

  relationships do
    belongs_to :user, GraphqlRbacExample.Accounts.User
    belongs_to :role, GraphqlRbacExample.Accounts.Role
  end
end
