defmodule TigerLilly.Guardian.BrowserAuthPipeline do
  use Guardian.Plug.Pipeline,
    otp_app: :tiger_lilly,
    module: TigerLilly.Guardian,
    error_handler: TigerLilly.AuthErrorHandler

  plug Guardian.Plug.VerifySession
  plug Guardian.Plug.LoadResource, allow_blank: true, ensure: true
  plug TigerLilly.CurrentUser
end
