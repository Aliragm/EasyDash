defmodule EasyDash.Accounts do
  alias EasyDash.Repo
  alias EasyDash.Accounts.User

  def get_user_by_email_and_password(email, password) do
    user = Repo.get_by(User, email: email)
    cond do
      user && Bcrypt.verify_pass(password, user.password_hash) ->
        {:ok, user}

      true ->
        Bcrypt.no_user_verify()
        {:error, :unauthorized}
    end
  end

  def create_user(attributes \\ %{}) do
    %User{}
    |> User.changeset(attributes)
    |> Repo.insert()
  end

end
