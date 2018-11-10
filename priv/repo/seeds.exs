IO.gets("Enter CSV file location: ")
|> String.trim()
|> Path.expand()
|> File.stream!()
|> CSV.decode(headers: true)
|> Enum.map(fn {:ok, %{"name" => name, "role" => title, "location" => location, "photo" => photo}} ->
  %{name: name, title: title, location: location, photo: photo}
end)
|> Enum.map(&People.Users.create_user/1)
|> Enum.map(fn {:ok, %People.Users.User{name: name}} ->
  IO.puts("Added user: " <> name)
end)
