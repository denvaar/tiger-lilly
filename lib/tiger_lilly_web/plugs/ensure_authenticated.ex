defmodule TigerLilly.Guardian.EnsureAuthenticated do
  use Guardian.Plug.Pipeline,
    otp_app: :tiger_lilly,
    module: TigerLilly.Guardian,
    error_handler: TigerLilly.AuthErrorHandler

  plug Guardian.Plug.EnsureAuthenticated
end
