defmodule MediaServer.MoviesSubtitle do
  def get_subtitle_path_for(id) do
    movie = MediaServer.MoviesIndex.get_movie(id)

    MediaServer.Subtitles.get_subtitle(movie["folderName"], movie["movieFile"]["relativePath"])
    |> MediaServer.Subtitles.handle_subtitle(movie["folderName"])
  end
end
