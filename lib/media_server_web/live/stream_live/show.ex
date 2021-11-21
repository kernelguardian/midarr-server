defmodule MediaServerWeb.StreamLive.Show do
  use MediaServerWeb, :live_view

  alias MediaServer.Media

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:file, Media.get_file!(id))
     }
  end

  @impl true
  def handle_event("publish_stream", _, socket) do
    uuid = Ecto.UUID.generate

    task = Task.async(fn ->
      Rambo.run(System.find_executable("ffmpeg"), ["-re", "-i", "#{socket.assigns.file.path}", "-c", "copy", "-f", "rtsp", "#{System.get_env("RTSP_SERVER_URL") || "rtsp://rtsp-simple-server:8554"}/#{uuid}"])
    end)

    {:noreply, push_event(
      socket 
      |> assign(:task, task)
      |> assign(:uuid, uuid), "stream_published", %{uuid: uuid})}
  end

  @impl true
  def handle_event("unpublish_stream", _, socket) do
    Rambo.kill(socket.assigns.task.pid)

    {:noreply, socket}
  end
end
