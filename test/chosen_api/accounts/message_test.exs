defmodule ChosenApi.Accounts.MessageTest do
  use ExUnit.Case
  import Swoosh.Email
  import Swoosh.TestAssertions

  import ChosenApiWeb.AuthCase
  alias ChosenApi.Accounts.Message

  setup do
    email = "deirdre@example.com"
    {:ok, %{email: email, key: gen_key(email)}}
  end

  test "sends confirmation request email", %{email: email, key: key} do
    {:ok, sent_email} = Message.confirm_request(email, key)
    assert_email_sent(
      subject: "podcasterinnen.org – Bestätige deine E-Mail-Adresse",
      text_body: "Liebe Podcasterin, liebe Podcastperson, bitte bestätige deine E-Mail-Adresse indem du auf folgenden Link klickst: http://localhost:3000/confirm?key=#{key}"
    )
  end

  test "sends no user found message for password reset attempt" do
    {:ok, sent_email} = Message.reset_request("gladys@example.com", nil)
    assert_email_sent(
      text_body: "Liebe Podcasterin, liebe Podcastperson, du hast gerade versucht dein Passwort zurückzusetzen, allerdings konnten wir keinen Userinnen-Account zu deiner E-Mail-Adresse finden. Schreib uns doch eine Mail an contact@podcasterinnen.org. Wir helfen dir gerne weiter. Das podcasterinnen.org-Team"
    )
  end

  test "sends reset password request email", %{email: email, key: key} do
    {:ok, sent_email} = Message.reset_request(email, key)
    assert_email_sent(
      subject: "podcasterinnen.org – Passwort zurücksetzen",
      text_body: "Liebe Podcasterin, liebe Podcastperson, du kannst dein Passwort hier http://localhost:3000/password_resets/edit?key=#{key} zurücksetzen."
    )
  end

  test "sends receipt confirmation email", %{email: email} do
    {:ok, sent_email} = Message.confirm_success(email)
    assert_email_sent(
      text_body: "Liebe Podcasterin, liebe Podcastperson, du hast dich erfolgreich bei http://localhost:3000 registriert. Um dir ein aussagekräftiges Profil anzulegen, kannst du dich erneut auf der http://localhost:3000/session einloggen und kannst dann sofort loslegen."
    )
  end

  test "sends password reset email", %{email: email} do
    {:ok, sent_email} = Message.reset_success(email)
    assert_email_sent(
      text_body: "Herzlichen Glückwunsch, dein Passwort wurde zurückgesetzt."
    )
  end
end
