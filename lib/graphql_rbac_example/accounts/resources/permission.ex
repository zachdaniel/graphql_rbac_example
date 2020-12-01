defmodule GraphqlRbacExample.Accounts.Permission do
  use Ash.Resource,
    data_layer: Ash.DataLayer.Ets,
    authorizers: [
      AshPolicyAuthorizer.Authorizer
    ],
    extensions: [
      AshGraphql.Resource
    ]

  graphql do
    type :permission

    queries do
      get :get_permission, :read
      list :list_permissions, :read
    end

    mutations do
      create :create_permission, :create
      update :update_permission, :update
      destroy :destroy_permission, :destroy
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

    attribute :type, :atom do
      constraints one_of: [:insert, :update, :delete, :query]
    end

    attribute :resource, :atom do
      constraints one_of: [:user, :role, :permission, :post]
    end
  end

  relationships do
    belongs_to :role, GraphqlRbacExample.Accounts.Role
  end
end
