defmodule MediaServer.Repo.Migrations.CreatePlaylistMedia do
  use Ecto.Migration

  def change do
    create table(:playlist_media) do
      add :playlists_id, references(:playlists, on_delete: :nothing), null: false
      add :media_id, references(:media, on_delete: :nothing), null: false

      timestamps()
    end
  end
end
