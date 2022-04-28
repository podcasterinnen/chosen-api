defmodule ChosenApi.Accounts.Message do
  @moduledoc """
  A module for sending messages, by email or phone, to the user.

  This module provides functions to be used with the Phauxth authentication
  library when confirming users or handling password resets. It uses
  Bamboo, with the LocalAdapter, which is a good development tool.
  For tests, it uses a test adapter, which is configured in the
  config/test.exs file.

  For production, you will need to setup a different email adapter.

  ## Bamboo with a different adapter

  Bamboo has adapters for Mailgun, Mailjet, Mandrill, Sendgrid, SMTP,
  SparkPost, PostageApp, Postmark and Sendcloud.

  There is also a LocalAdapter, which is great for local development.

  See [Bamboo](https://github.com/thoughtbot/bamboo) for more information.

  ## Other email / phone library

  If you do not want to use Bamboo, follow the instructions below:

  1. Edit this file, using the email / phone library of your choice
  2. Remove the lib/chosen_api/mailer.ex file
  3. Remove the Bamboo entries in the config/config.exs and config/test.exs files
  4. Remove bamboo from the deps section in the mix.exs file

  """

  import Swoosh.Email
  alias ChosenApi.Mailer

  @doc """
  An email with a confirmation link in it.
  """
  def confirm_request(address, key) do
    domain = Application.get_env(:chosen_api, :template_domain, "http://localhost:3000")

    prep_mail(address)
    |> subject("podcasterinnen.org – Bestätige deine E-Mail-Adresse")
    |> text_body("Liebe Podcasterin, liebe Podcastperson, bitte bestätige deine E-Mail-Adresse indem du auf folgenden Link klickst: #{domain}/confirm?key=#{key}")
    |> Mailer.deliver()
  end

  @doc """
  An email with a link to reset the password.
  """
  def reset_request(address, nil) do
    prep_mail(address)
    |> subject("podcasterinnen.org – Passwort zurücksetzen")
    |> text_body(
        "Liebe Podcasterin, liebe Podcastperson, du hast gerade versucht dein Passwort zurückzusetzen, allerdings konnten wir keinen Userinnen-Account zu deiner E-Mail-Adresse finden. Schreib uns doch eine Mail an contact@podcasterinnen.org. Wir helfen dir gerne weiter. Das podcasterinnen.org-Team"
      )
    |> Mailer.deliver()
  end

  def reset_request(address, key) do
    domain = Application.get_env(:chosen_api, :template_domain, "http://localhost:3000")

    prep_mail(address)
    |> subject("podcasterinnen.org – Passwort zurücksetzen")
    |> text_body(
        "Liebe Podcasterin, liebe Podcastperson, du kannst dein Passwort hier #{domain}/password_resets/edit?key=#{key} zurücksetzen."
      )
    |> Mailer.deliver()
  end

  @doc """
  An email acknowledging that the account has been successfully confirmed.
  """
  def confirm_success(address) do
    domain = Application.get_env(:chosen_api, :template_domain, "http://localhost:3000")

    prep_mail(address)
    |> subject("podcasterinnen.org – Deine E-Mail-Adresse wurde bestätigt")
    |> text_body("Liebe Podcasterin, liebe Podcastperson, du hast dich erfolgreich bei #{domain} registriert. Um dir ein aussagekräftiges Profil anzulegen, kannst du dich erneut auf der #{domain}/session einloggen und kannst dann sofort loslegen.")
    |> Mailer.deliver()
  end

  @doc """
  An email acknowledging that the password has been successfully reset.
  """
  def reset_success(address) do
    prep_mail(address)
    |> subject("podcasterinnen.org – Passwort zurückgesetzt")
    |> text_body("Herzlichen Glückwunsch, dein Passwort wurde zurückgesetzt.")
    |> Mailer.deliver()
  end

  defp prep_mail(address) do
    new()
    |> to(address)
    |> from("no-reply@podcasterinnen.org")
  end
end
