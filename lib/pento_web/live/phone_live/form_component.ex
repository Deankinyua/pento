defmodule PentoWeb.PhoneLive.FormComponent do
  use PentoWeb, :live_component

  alias Pento.Category

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
        <:subtitle>Use this form to manage phone records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="phone-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:name]} type="text" label="Name" />
        <.input field={@form[:description]} type="text" label="Description" />
        <.input field={@form[:price]} type="number" label="Price" />
        <:actions>
          <.button phx-disable-with="Saving...">Save Phone</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{phone: phone} = assigns, socket) do
    changeset = Category.change_phone(phone)

    {:ok,
     socket
     |> assign(assigns)
     |> assign_form(changeset)}
  end

  @impl true
  def handle_event("validate", %{"phone" => phone_params}, socket) do
    changeset =
      socket.assigns.phone
      |> Category.change_phone(phone_params)
      |> Map.put(:action, :validate)

    {:noreply, assign_form(socket, changeset)}
  end

  def handle_event("save", %{"phone" => phone_params}, socket) do
    save_phone(socket, socket.assigns.action, phone_params)
  end

  defp save_phone(socket, :edit, phone_params) do
    case Category.update_phone(socket.assigns.phone, phone_params) do
      {:ok, phone} ->
        notify_parent({:saved, phone})

        {:noreply,
         socket
         |> put_flash(:info, "Phone updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp save_phone(socket, :new, phone_params) do
    case Category.create_phone(phone_params) do
      {:ok, phone} ->
        notify_parent({:saved, phone})

        {:noreply,
         socket
         |> put_flash(:info, "Phone created successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp assign_form(socket, %Ecto.Changeset{} = changeset) do
    assign(socket, :form, to_form(changeset))
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end
