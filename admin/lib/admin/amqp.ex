defmodule Admin.AMQPAdapter do

  require AMQP
  require Logger

  @state %{host: "localhost", port: 5672, user: "rabbit", pass: "rabbit"}

  def state, do: @state

  defp connect do
    case AMQP.Connection.open(host: @state.host, port: @state.port, username: @state.user, password: @state.pass) do
      {:ok, %AMQP.Connection{} = conn} ->
        conn
      {:error, _} ->
        Logger.error "Connection to amqp://#{@state.user}:#{@state.pass}@#{@state.host}:#{@state.port} went wrong"
        nil
    end
  end

  defp channel(conn) do
    case AMQP.Channel.open(conn) do
      {:ok, channel} ->
        channel
      {:error, _} ->
        Logger.error "Channel can't be opened with amqp://#{@state.user}:#{@state.pass}@#{@state.host}:#{@state.port}"
        nil
    end
  end

  defp queue(channel, name \\ "admin") do
    case AMQP.Queue.declare(channel, name) do
      {:ok, %{}} ->
        channel
      {:error, _} ->
        Logger.error "Channel #{name} can't be opened in amqp://#{@state.user}:#{@state.pass}@#{@state.host}:#{@state.port}"
        nil
    end
  end

  defp close(conn), do: AMQP.Connection.close(conn)

  def push(msg,  queue \\ "admin") do
    conn = connect
    conn |> channel |> queue(queue) |> AMQP.Basic.publish("", queue, msg, content_type: "application/json")
    close conn
  end

end
