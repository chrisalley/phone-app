defmodule PhoneAppWeb.MessageHTML do
  use PhoneAppWeb, :html

  # Define the attributes that go into the message_form
  # component, located inside of the templates directory
  alias PhoneApp.Conversations

  attr :changeset, Ecto.Changeset, required: true
  attr :contact, Conversations.Schema.Contact, required: false, default: nil

  def message_form(assigns)

  embed_templates "message_html/*"
end
