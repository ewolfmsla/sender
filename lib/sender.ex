defmodule Sender do
  @moduledoc """
  Documentation for `Sender`.
  """

  @doc """
  Hello world.

  ## Examples

      iex> Sender.hello()
      :world

  """
  def hello do
    :world
  end

  def notify_all(emails) do
    Sender.EmailTaskSupervisor
    |> Task.Supervisor.async_stream_nolink(emails, &send_email/1)
    |> Enum.to_list()
    |> Stream.filter(fn {key, _} -> :exit == key end)
    |> Enum.map(fn {_, val} -> 
        case val do
          {%{message: message}, _} -> message
          _ -> val
        end
     end)
  end

  def send_email("foo@bar.com" = email), do: raise("Oops, couldn't send email to #{email}")

  def send_email(email) do
    IO.puts("email to #{email} sent!")
    {:ok, "email sent"}
  end

  def run("foo@bar.com") do 
    IO.puts("sending to foo@bar.com...")
    Process.sleep(20_000)
    raise("ouch!")
  end

  def run (email) do
    IO.puts("sending to #{email}...")
    Process.sleep(20_000)
    {:ok, "email sent to #{email}"}
  end
end
