defmodule Datalocker.Scrape do

  def start(url) do
    %{
      title: title(url),
      type: item_type(url),
      favicon: favicon(url)
    }
  end

  def item_type(url) do
    cond do
      String.match?(url, ~r/\.(jpg|gif|png)/) ->
        "image"
      String.match?(url, ~r/\.(pdf|doc|txt)/) ->
        "document"
      String.length(url) > 0 ->
        "html"
    end
  end

  def title(url) do
    body = HTTPoison.get!(url,[], [
      ssl: [ {:versions, [:'tlsv1.2']} ]
    ]).body
    if item_type(url) == "html" do
      Floki.find(body, "title") |> Floki.text
    else
      String.split(url, "/") |> List.last
    end
  end

  def favicon(url) do
      result = HTTPoison.get!(hostname(url) <> "/favicon.ico",[], [
        ssl: [ {:versions, [:'tlsv1.2']} ]
      ]).headers
    {_, length} = Enum.find(result, fn({k,_}) -> k == "Content-Length" end)

    if String.to_integer(length) > 0 do
      hostname(url) <> "/favicon.ico"
    else
      find_favicon(url)
    end
  end

  defp find_favicon(url) do
    body = HTTPoison.get!(url,[], [
      ssl: [ {:versions, [:'tlsv1.2']} ]
    ]).body

    if item_type(url) == "html" do
      icon_path = favicon_path(body)
      cond do
        String.starts_with?(icon_path, "http") ->
          icon_path
        String.starts_with?(icon_path, "//") ->
          "http:" <> icon_path
        String.trim(icon_path) != "" ->
          if String.starts_with?(icon_path, "/") do
            hostname(url) <> icon_path
          else
            hostname(url) <> "/" <> icon_path
          end
        String.trim(icon_path) == "" ->
          ""
      end
    else
      ""
    end
  end

  defp favicon_path(body) do
    initial_result = Floki.find(body, "link[rel*='icon'")
    if (length initial_result) > 1 do
      next_result = initial_result |> Floki.find("[rel*='shortcut']")
      if (length next_result) > 0 do
        next_result
          |> Floki.attribute("href")
          |> Floki.text
      else
        List.first(initial_result)
          |> Floki.attribute("href")
          |> Floki.text
      end
    else
      initial_result
        |> Floki.attribute("href")
        |> Floki.text
    end
  end

  defp hostname(url) do
    uri = URI.parse(url)
    uri.scheme <> "://" <> uri.host
  end
# glyphicon glyphicon-picture
end
