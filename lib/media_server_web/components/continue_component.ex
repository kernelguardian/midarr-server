defmodule MediaServerWeb.Components.ContinueComponent do
  use MediaServerWeb, :live_component

  def handle_event("delete_movie", %{"id" => id}, socket) do
    MediaServer.Accounts.UserContinues.delete(id)

    {
      :noreply,
      socket
      |> push_redirect(to: Routes.continues_index_path(socket, :index))
    }
  end

  def handle_event("delete_episode", %{"id" => id}, socket) do
    MediaServer.Accounts.UserContinues.delete(id)

    {
      :noreply,
      socket
      |> push_redirect(to: Routes.continues_index_path(socket, :index))
    }
  end
end
