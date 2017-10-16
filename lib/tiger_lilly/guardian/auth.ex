defmodule TigerLilly.Auth do
  alias TigerLilly.Blog
  alias TigerLilly.Blog.User

  def authenticate(email, password) do
    user = Blog.get_user_by_email(email)

    case check_password(user, password) do
      false ->
        {:error, Blog.change_user(%User{})}
      true ->
        {:ok, user}
    end
  end

  def make_hash(nil), do: ""
  def make_hash(""), do: ""
  def make_hash(password), do: Comeonin.Bcrypt.hashpwsalt(password)

  defp check_password(nil, _password), do: false
  defp check_password(user, password) do
    Comeonin.Bcrypt.checkpw(password, user.password_hash)
  end
end
