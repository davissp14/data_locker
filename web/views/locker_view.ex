defmodule Datalocker.LockerView do
  use Datalocker.Web, :view

  def favicon(url) do
    obj = URI.parse(url)
    case extension(url) do
      "pdf" ->
        "http://www.bimeccanica.it/resources/uploads/generale/Adobe_PDF_Logo.gif"
      "gif" ->
        "https://image.freepik.com/free-icon/picture-frame-with-mountain-image_318-40293.jpg"
      _ ->
        obj.scheme <> "://" <> obj.host <> "/favicon.ico"
    end
  end

  def extension(url) do
    obj = URI.parse(url)
    extension = "html"
    if obj.path do
      array = String.split(obj.path, ".")
      if length(array) > 1 do
        extension = List.last(array)
      end
    end
    if obj.host == "www.youtube.com" do
      extension = "youtube"
    end
    extension
  end

  def display_url(url) do
    slice = String.slice(url, 0..40)
    if String.length(slice) > 40 do
      slice <> " ..."
    else
      slice
    end
    link slice, to: url, target: "_new"
  end

  def link_category(url) do
    extension(url)
  end


end
