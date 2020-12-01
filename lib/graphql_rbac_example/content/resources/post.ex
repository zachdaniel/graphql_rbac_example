defmodule GraphqlRbacExample.Content.Post do
  use Ash.Resource,
    data_layer: Ash.DataLayer.Ets,
    authorizers: [
      AshPolicyAuthorizer.Authorizer
    ],
    extensions: [
      AshGraphql.Resource
    ]

  graphql do
    type :post

    queries do
      get :get_post, :read
      list :list_posts, :read
    end

    mutations do
      create :create_post, :create
      update :update_post, :update
      destroy :destroy_post, :destroy
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
    attribute :content, :string
  end
end
