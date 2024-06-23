defmodule PhoneApp.Conversations do
  alias PhoneApp.Conversations.Query
  alias PhoneApp.Conversations.Schema

  defdelegate get_contact!(id), to: Query.ContactStore
  defdelegate create_sms_message(params), to: Query.SmsMessageStore
  defdelegate update_sms_message(sid, params), to: Query.SmsMessageStore
  defdelegate new_message_changeset(params), to: Schema.NewMessage, as: :changeset

  def load_conversation_list do
    messages = Query.SmsMessageStore.load_message_list()

    Enum.map(messages, fn message ->
      %Schema.Conversation{
        contact: message.contact,
        messages: [message]
      }
    end)
  end

  def load_conversation_with(contact) do
    messages = Query.SmsMessageStore.load_messages_with(contact)
    %Schema.Conversation{contact: contact, messages: messages}
  end

  def send_sms_message(params = %Schema.NewMessage{}) do
    # This version of send_sms_message uses mock data, it doesn't
    # make an HTTP request.
    #
    # Later, we will write a new version that sends an HTTP request
    # to a mock SMS server.
    params = %{
      message_sid: "mock-" <> Ecto.UUID.generate(),
      account_sid: "mock",
      body: params.body,
      from: "mock",
      to: params.to,
      status: "mock",
      direction: :outgoing
    }

    create_sms_message(params)
  end
end
