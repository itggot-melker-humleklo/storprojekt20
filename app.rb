require 'sinatra'
require 'slim'
require 'sqlite3'


get('/')  do
  slim(:index)
end 

post("/create") do
  title_id = params[:title]
  artist_id = params[:artist]
  db = SQLite3::Database.new("db/chinook.db")
  db.results_as_hash = true
  result = db.execute("INSERT INTO albums (Title, ArtistId) VALUES (?,?)", title_id, artist_id)
  redirect("/")
end

post("/update") do
  title_id = params[:title]
  album_id = params[:album]
  db = SQLite3::Database.new("db/chinook.db")
  db.results_as_hash = true
  result = db.execute("UPDATE albums SET Title = ? WHERE AlbumId = ?", title_id, album_id)
  redirect("/")
end

post("/delete") do
  album_id = params[:album]
  db = SQLite3::Database.new("db/chinook.db")
  db.results_as_hash = true
  result = db.execute("DELETE FROM albums WHERE AlbumId = ?", album_id)
  redirect("/")
end


get('/show_all_albums') do
  db = SQLite3::Database.new("db/chinook.db")
  db.results_as_hash = true
  result = db.execute("SELECT Title FROM albums")
  p result
  slim(:albums,locals:{albums:result})
end

get('/show_album') do
  id = params[:number]
  p id
  db = SQLite3::Database.new("db/chinook.db")
  db.results_as_hash = true
  result = db.execute("SELECT * FROM albums WHERE AlbumId = ?",id)
  p result
  slim(:show_album,locals:{result:result.first})
end