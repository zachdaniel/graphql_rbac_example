defmodule GraphqlRbacExample.Accounts.User do
  use Ash.Resource,
    data_layer: Ash.DataLayer.Ets,
    authorizers: [
      AshPolicyAuthorizer.Authorizer
    ],
    extensions: [
      AshGraphql.Resource
    ]

  import GraphqlRbacExample.Checks.Rbac

  graphql do
    type :user

    queries do
      get :get_user, :read
      list :list_users, :read
    end

    mutations do
      create :create_user, :create
      update :update_user, :update
      destroy :destroy_user, :destroy
    end
  end

  policies do
    policy action_type(:read) do
      authorize_if rbac(:user, :query)
    end

    policy action_type(:update) do
      authorize_if rbac(:user, :update)
    end

    policy action_type(:destroy) do
      authorize_if rbac(:user, :delete)
    end

    policy action_type(:create) do
      authorize_if rbac(:user, :insert)
    end
  end

  actions do
    create :create
    read :read
    update :update
    destroy :destroy
  end

  attributes do
    uuid_primary_key :id do
      writable? true
    end

    attribute :username, :string
  end

  relationships do
    many_to_many :roles, GraphqlRbacExample.Accounts.Role,
      through: GraphqlRbacExample.Accounts.UserRole,
      source_field_on_join_table: :user_id,
      destination_field_on_join_table: :role_id
  end
end
