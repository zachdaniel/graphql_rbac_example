defmodule GraphqlRbacExampleWeb.Router do
  use GraphqlRbacExampleWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {GraphqlRbacExampleWeb.LayoutView, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :fake_user do
    plug GraphqlRbacExample.Plugs.FakeUser
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", GraphqlRbacExampleWeb do
    pipe_through :browser

    live "/", PageLive, :index
  end

  scope "/" do
    pipe_through :fake_user
    forward "/gql", Absinthe.Plug, schema: GraphqlRbacExample.Schema

    forward "/playground",
            Absinthe.Plug.GraphiQL,
            schema: GraphqlRbacExample.Schema,
            interface: :playground
  end

  # Other scopes may use custom stacks.
  # scope "/api", GraphqlRbacExampleWeb do
  #   pipe_through :api
  # end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through :browser
      live_dashboard "/dashboard", metrics: GraphqlRbacExampleWeb.Telemetry
    end
  end
end
