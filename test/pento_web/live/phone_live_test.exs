defmodule PentoWeb.PhoneLiveTest do
  use PentoWeb.ConnCase

  import Phoenix.LiveViewTest
  import Pento.CategoryFixtures

  @create_attrs %{name: "some name", description: "some description", price: 42}
  @update_attrs %{name: "some updated name", description: "some updated description", price: 43}
  @invalid_attrs %{name: nil, description: nil, price: nil}

  defp create_phone(_) do
    phone = phone_fixture()
    %{phone: phone}
  end

  describe "Index" do
    setup [:create_phone]

    test "lists all phones", %{conn: conn, phone: phone} do
      {:ok, _index_live, html} = live(conn, ~p"/phones")

      assert html =~ "Listing Phones"
      assert html =~ phone.name
    end

    test "saves new phone", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/phones")

      assert index_live |> element("a", "New Phone") |> render_click() =~
               "New Phone"

      assert_patch(index_live, ~p"/phones/new")

      assert index_live
             |> form("#phone-form", phone: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#phone-form", phone: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/phones")

      html = render(index_live)
      assert html =~ "Phone created successfully"
      assert html =~ "some name"
    end

    test "updates phone in listing", %{conn: conn, phone: phone} do
      {:ok, index_live, _html} = live(conn, ~p"/phones")

      assert index_live |> element("#phones-#{phone.id} a", "Edit") |> render_click() =~
               "Edit Phone"

      assert_patch(index_live, ~p"/phones/#{phone}/edit")

      assert index_live
             |> form("#phone-form", phone: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#phone-form", phone: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/phones")

      html = render(index_live)
      assert html =~ "Phone updated successfully"
      assert html =~ "some updated name"
    end

    test "deletes phone in listing", %{conn: conn, phone: phone} do
      {:ok, index_live, _html} = live(conn, ~p"/phones")

      assert index_live |> element("#phones-#{phone.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#phones-#{phone.id}")
    end
  end

  describe "Show" do
    setup [:create_phone]

    test "displays phone", %{conn: conn, phone: phone} do
      {:ok, _show_live, html} = live(conn, ~p"/phones/#{phone}")

      assert html =~ "Show Phone"
      assert html =~ phone.name
    end

    test "updates phone within modal", %{conn: conn, phone: phone} do
      {:ok, show_live, _html} = live(conn, ~p"/phones/#{phone}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Phone"

      assert_patch(show_live, ~p"/phones/#{phone}/show/edit")

      assert show_live
             |> form("#phone-form", phone: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#phone-form", phone: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/phones/#{phone}")

      html = render(show_live)
      assert html =~ "Phone updated successfully"
      assert html =~ "some updated name"
    end
  end
end
