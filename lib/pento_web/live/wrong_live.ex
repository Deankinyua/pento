defmodule PentoWeb.WrongLive do
  use PentoWeb, :live_view

  def render(assigns) do
    ~H"""
    <h1>Your score: <%= @score %></h1>
    <h2>
      <%= @message %>
    </h2>
    <h2>
      <%= for n <- 1..5 do %>
        <a href="#" phx-click="guess" phx-value-number={n}><%= n %></a>
      <% end %>
    </h2>
    <h2>
      It's <%= @time %>
    </h2>
    <button phx-click="restartGame">Restart</button>
    <pre>
    <%= @user.email %>
    <%= @session_id %>
    </pre>
    """
  end

  def time() do
    DateTime.utc_now() |> to_string
  end

  def mount(_params, session, socket) do
    {
      :ok,
      assign(
        socket,
        score: 0,
        message: "Guess a number.",
        time: time(),
        user: Pento.Accounts.get_user_by_session_token(session["user_token"]),
        session_id: session["live_socket_id"]
      )
    }
  end

  def handle_event("restartGame", _value, socket) do
    {:noreply,
     socket
     |> redirect(to: ~p"/guess")}
  end

  def handle_event("guess", %{"number" => guess} = data, socket) do
    IO.inspect(data)
    guess = String.to_integer(guess)
    number = Enum.random(1..5)

    if guess === number do
      message = "Your guess: #{guess}. Won. Restart the Game."
      score = socket.assigns.score + 1

      {
        :noreply,
        assign(
          socket,
          message: message,
          score: score,
          time: time()
        )
      }
    else
      message = "Your guess: #{guess}. Wrong. Guess again. "
      score = socket.assigns.score - 1

      {
        :noreply,
        assign(
          socket,
          message: message,
          score: score,
          time: time()
        )
      }
    end
  end
end
