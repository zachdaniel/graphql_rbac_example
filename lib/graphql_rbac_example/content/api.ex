defmodule GraphqlRbacExample.Content.Api do
  use Ash.Api,
    extensions: [AshGraphql.Api]

  alias GraphqlRbacExample.Content.Post

  resources do
    resource Post
  end
end
