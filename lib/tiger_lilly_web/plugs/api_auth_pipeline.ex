defmodule TigerLilly.Guardian.ApiAuthPipeline do
  use Guardian.Plug.Pipeline,
    otp_app: :tiger_lilly,
    module: TigerLilly.Guardian,
    error_handler: TigerLilly.ApiAuthErrorHandler

  plug Guardian.Plug.VerifyHeader, realm: "Bearer"
  plug Guardian.Plug.EnsureAuthenticated
  plug Guardian.Plug.LoadResource, ensure: true, allow_blank: true
  plug TigerLilly.CurrentUser
end
