defmodule GraphqlRbacExample.Accounts.Role do
  use Ash.Resource,
    data_layer: Ash.DataLayer.Ets,
    authorizers: [
      AshPolicyAuthorizer.Authorizer
    ],
    extensions: [
      AshGraphql.Resource
    ]

  graphql do
    type :role

    queries do
      get :get_role, :read
      list :list_roles, :read
    end

    mutations do
      create :create_role, :create
      update :update_role, :update
      destroy :destroy_role, :destroy
    end
  end

  actions do
    create :create
    read :read
    update :update
    destroy :destroy
  end

  attributes do
    uuid_primary_key :id

    attribute :name, :string do
      allow_nil? false
    end
  end

  relationships do
    has_many :permissions, GraphqlRbacExample.Accounts.Permission, destination_field: :role_id
  end
end
