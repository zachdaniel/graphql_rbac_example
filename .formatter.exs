[
  import_deps: [:ecto, :phoenix, :ash, :ash_graphql, :ash_policy_authorizer],
  inputs: ["*.{ex,exs}", "priv/*/seeds.exs", "{config,lib,test}/**/*.{ex,exs}"],
  subdirectories: ["priv/*/migrations"]
]
