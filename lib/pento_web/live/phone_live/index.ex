defmodule PentoWeb.PhoneLive.Index do
  use PentoWeb, :live_view

  alias Pento.Category
  alias Pento.Category.Phone

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :phones, Category.list_phones())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Phone")
    |> assign(:phone, Category.get_phone!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Phone")
    |> assign(:phone, %Phone{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Phones")
    |> assign(:phone, nil)
  end

  @impl true
  def handle_info({PentoWeb.PhoneLive.FormComponent, {:saved, phone}}, socket) do
    {:noreply, stream_insert(socket, :phones, phone)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    phone = Category.get_phone!(id)
    {:ok, _} = Category.delete_phone(phone)

    {:noreply, stream_delete(socket, :phones, phone)}
  end
end
