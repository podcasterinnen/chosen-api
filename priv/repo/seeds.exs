# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# It is also run when you use the command `mix ecto.setup`
#

users = [
  %{email: "jane.doe@example.com", password: "password12341234"},
  %{email: "john.smith@example.org", password: "password12341234"}
]

for user <- users do
  {:ok, user} = ChosenApi.Accounts.create_user(user)
  ChosenApi.Accounts.confirm_user(user)
end
