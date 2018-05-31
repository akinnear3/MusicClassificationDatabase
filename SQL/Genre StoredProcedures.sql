--// these are all th stored procedures that directly querry, add, remove or update Genres
use MusicClassificationDatabase
go

drop procedure fetchGenreBySongID
drop procedure RemoveGenreReferencesBySong
drop procedure DeleteGenreToSong
drop procedure fetchGenres
drop procedure AddGenreToSong
go


--returns the genre and genreID using GenresToSongs as a makeshift array
create procedure fetchGenreBySongID(@SongID int = null) as
	if @SongID = null
		BEGIN
			raiserror('genre not supplied', 16, 1)
		END
	else
		BEGIN
			select g.GenreID, g.genre, SongID
				from GenresToSongs join Genres g on g.GenreID = GenresToSongs.GenreID
				where SongID = @SongID
		END
return
go

--//this removes references of genres to a song from GenresToSongs
create procedure RemoveGenreReferencesBySong (@SongID int = null) as 
		Delete GenresToSongs
			where SongID = @SongID
return
go

--//this fetches all the genres
create procedure fetchGenres as
	select GenreID, genre 
		from Genres
return
go

create procedure DeleteGenreToSong(@SongID int = null,  @GenreID int = null) as
	if @SongID = null or @GenreID = null 
		Raiserror('missing parameter(s). Deleting genreToSong requires songID and GenreID', 16, 1)
	Delete From GenresToSongs
		where GenreID = @GenreID and
				SongID = @SongID
	if @@ROWCOUNT = 0
		raiserror(' Delete Failed. No Rows Affected.', 16, 1)
return
go

--//create a reference between a genre and a song
create procedure AddGenreToSong(@songID int = null, @genreID int = null) as
	if @genreID = null or @songID = null
		raiserror('Missing Parameter(s). Pleas provide songID and GenreID to add a Genre to song reference.', 16, 1)
	else
		BEGIN
			insert into GenresToSongs(SongID, GenreID)  values(@songID, @genreID)
		END
return
go

--//creates a new genre
create procedure AddGenre(@genreName varchar(100) = null) as
	if @genreName = null
		raiserror('no genre name provided', 16, 1)
	else
		BEGIN
			insert into Genres(genre) values (@genreName)
		END
return
go

--//deletes a genre by id
create procedure DeleteGenre(@genreID int = null) as
	if @genreID = null
		raiserror('no genreID supplied', 16, 1)
	else if EXISTS(select GenreID from GenresToSongs where GenreID = @genreID)
		raiserror('genre is currently being used and cannot be deleted', 16, 1)
	else 
		BEGIN
			Delete from Genres	
				where GenreID = @genreID
		END
go

--//sear genres by partial name
create procedure searchGenres(@partialGenre varchar(100) = null) as
	if @partialGenre = null
		raiserror('Missing Parameter. partial genre required to search genres', 16, 1)
	else if @partialGenre = '__No_th_ing_'
		BEGIN 
			exec fetchGenres
		END
	else
		BEGIN
			select GenreID, genre 
				from Genres 
				where genre like ('%' + @partialGenre + '%')
		END
return 
go
--------------------------------------------------------------------------------------------

go



create procedure UpdateGenre(@genreID int = null, @genrename varchar = null) as

go




create procedure fetchGenreToSongs as
	select GenreID, SongID 
		from GenresToSongs
go

create procedure UpdateGenreToSong(@GenreID int = null, @SongID int = null) as

go


