defmodule PhoneApp.Conversations.Schema.SmsMessage do
  use Ecto.Schema
  import Ecto.Changeset

  @timestamps_opts [type: :utc_datetime_usec]
  schema "sms_messages" do
    belongs_to :contact, PhoneApp.Conversations.Schema.Contact

    field :message_sid, :string
    field :account_sid, :string
    field :body, :string
    field :from, :string
    field :to, :string
    field :status, :string
    field :direction, Ecto.Enum, values: [:incoming, :outgoing]

    timestamps()
  end

  def changeset(attrs) do
    fields = [
      :contact_id,
      :message_sid,
      :account_sid,
      :body,
      :from,
      :to,
      :status,
      :direction
    ]

    %__MODULE__{}
    |> cast(attrs, fields)
    |> validate_required(fields)
    |> unique_constraint([:message_sid])
  end

  def update_changeset(attrs, struct = %__MODULE__{}) do
    fields = [:status]

    struct
    |> cast(attrs, fields)
    |> validate_required(fields)
  end
end
