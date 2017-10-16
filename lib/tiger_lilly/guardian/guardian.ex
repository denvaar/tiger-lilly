defmodule TigerLilly.Guardian do
  use Guardian, otp_app: :tiger_lilly

  alias TigerLilly.Repo
  alias TigerLilly.Blog.User

  def subject_for_token(user = %User{}, _claims) do
    {:ok, "User:" <> to_string(user.id)}
  end
  def subject_for_token(_, _) do
    {:error, :unknown_resource}
  end

  def resource_from_claims(%{"sub" => "User:" <> id}) do
    try do
      case Integer.parse(id) do
        {id, ""} ->
          {:ok, Repo.get(User, id)}
        _ ->
          {:error, :invalid_id}
      end
      rescue
        Ecto.NoResultsError -> {:error, :no_result}
    end
  end
  def resource_from_claims(_claims) do
    {:error, "not found"}
  end
end
