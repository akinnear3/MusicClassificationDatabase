
--// these are all th stored procedures that directly querry, add, remove or update songs
use MusicClassificationDatabase
go

drop procedure fetchAllSongs
drop procedure fetchSongsByName
drop procedure fetchSongsByGenre
drop procedure fetchSongsByRating
drop procedure fetchSongsByFiletype
drop procedure fetchSongBySongID

drop procedure fetchSongsByAll
drop procedure deleteSong

drop procedure createSong
drop procedure updateSong
go

--//gets all of the songs in the songs table
create procedure fetchAllSongs as
	select SongID, SongName, FiletypeID
		From Songs
	return
go

--//gets a song's information
create procedure fetchSongBySongID (@songID int = null) as
	select SongName, FiletypeID
		from Songs
		where SongID = @songID
go

--//gets all of the songs in the songs table with the partial name in it
Create procedure fetchSongsByName(@partialSongName varchar(100) = null) as
	if (@partialSongName = null)
		BEGIN
			raiserror('partial song name not provided',16 , 1)
		END
	else
		BEGIN
			select SongID, SongName, FiletypeID
				From Songs
				where SongName Like('%'+@partialSongName+'%')
		END
return
go

--//return the songs from a search based on genreID
create procedure fetchSongsByGenre(@genreID int = null) as
	if @genreID = null
		raiserror('no genre provided', 16, 1)
	else if @genreID = 0
		BEGIN
				raiserror('all songs were listed; no specific genre selected', 10, 1)
				EXEC fetchAllSongs
		END

	else
		BEGIN
			select SongID, SongName, FiletypeID
			from Songs
				where SongID in (select SongID
									from GenresToSongs
									where GenreID = @genreID)
		END
	return
go

--//returns the songs from a search based on ratingID
create procedure fetchSongsByRating(@ratingID int = null) as
	if @ratingID = null
		raiserror('no rating provided', 16, 1)
	else if @ratingID = 0
		BEGIN
				raiserror('all songs were listed; no specific rating selected', 10, 1)
				EXEC fetchAllSongs
		END

	else
		BEGIN
			select SongID, SongName, FiletypeID
				from Songs
				where songID in (select SongID
									from RatingsToSongs 
									where ratingID = @ratingID)
		END
	return
go

--//returns songs based on filetypeID
create procedure fetchSongsByFiletype(@filetypeID int = null) as
	if @filetypeID = null 
		raiserror('parameter not provided; fetchSongsByFiletype err', 16, 1)
	else 
		BEGIN
			select SongID, SongName, FiletypeID
				from Songs
				where FiletypeID = @filetypeID

		END
	return
go

-- accomidates all of the different aspects of a song; 0 is treated as 'any' for a particular choise
Create procedure fetchSongsByAll(@pSongName varchar(100) = null, @artistID int = null,@genreID int = null, @ratingID int = null, @filetypeID int = null) as 
	if @pSongName = '__Nothing__'
		begin
			Set @pSongName = '' 
		end
	else
	BEGIN
		set @pSongName = REPLACE(@pSongName, '_re_plac_ing_', ' ')
	END
	if @pSongName = null or @genreID = null or @ratingID = null or @filetypeID = null or @artistID = null
		raiserror('a parameter is not provided or has become null; fetch songs by all err.', 16, 1)
	else if @artistID = 0 and @genreID = 0 and @ratingID = 0 and @filetypeID = 0
		BEGIN
			EXEC fetchSongsByName @partialSongName = @pSongName
		END
	else if @artistID = 0 and @genreID = 0 and @ratingID = 0 /* and @filetypeID = 0 */
		BEGIN
			select songID, SongName, FiletypeID 
				from Songs
				where SongID in (select SongID--//meets partial name requirment
									From Songs
									where SongName Like('%'+@pSongName+'%'))
					and FiletypeID = @filetypeID
		END
	else if @artistID = 0 and @genreID = 0 /*and @ratingID = 0 */ and @filetypeID = 0
		BEGIN
			select songID, SongName, FiletypeID 
				from Songs
				where SongID in (select SongID--//meets partial name requirment
									From Songs
									where SongName Like('%'+@pSongName+'%'))
					and SongID in (select SongID--//meets rating requirment
									from RatingsToSongs 
									where RatingID = @ratingID)
		END
	else if @artistID = 0 /*and @genreID = 0*/ and @ratingID = 0 and @filetypeID = 0
		BEGIN
			select songID, SongName, FiletypeID 
				from Songs
				where SongID in (select SongID--//meets partial name requirment
									From Songs
									where SongName Like('%'+@pSongName+'%'))
					and SongID in (select SongID--//meets genre requirment
									from GenresToSongs 
									where GenreID = @genreID)
		END
	else if /*@artistID = 0 and*/ @genreID = 0 and @ratingID = 0 and @filetypeID = 0
		BEGIN
			select songID, SongName, FiletypeID
				from Songs
				where SongID in (select SongID--//meets partial name requirment
									From Songs
									where SongName Like('%'+@pSongName+'%'))
					and SongID in (select SongID--//meets artist requirment
									from ArtistsToSongs 
									where ArtistID = @artistID)
		END
	else if @artistID = 0 and @genreID = 0 /*and @ratingID = 0 and @filetypeID = 0*/
		BEGIN
			select songID, SongName, FiletypeID
				from Songs
				where SongID in (select SongID--//meets partial name requirment
									From Songs
									where SongName Like('%'+@pSongName+'%'))
					and SongID in (select SongID--//meets rating requirment
									from RatingsToSongs 
									where RatingID = @ratingID)
					and FiletypeID = @filetypeID--//meets filetype requirment
		END
	else if @artistID = 0 /*and @genreID = 0*/ and @ratingID = 0 /*and @filetypeID = 0*/
		BEGIN
			select songID, SongName, FiletypeID
				from Songs
				where SongID in (select SongID--//meets partial name requirment
									From Songs
									where SongName Like('%'+@pSongName+'%'))
					and SongID in (select SongID--//meets genre requirment
									from GenresToSongs 
									where GenreID = @genreID)
					and FiletypeID = @filetypeID--//meets filetype requirment
		END
	else if /*@artistID = 0 and*/ @genreID = 0 and @ratingID = 0 /*and @filetypeID = 0*/
		BEGIN
			select songID, SongName, FiletypeID
				from Songs
				where SongID in (select SongID--//meets partial name requirment
									From Songs
									where SongName Like('%'+@pSongName+'%'))
					and SongID in (select SongID--//meets artist requirment
									from ArtistsToSongs 
									where ArtistID = @artistID)
					and FiletypeID = @filetypeID--//meets filetype requirment
		END
	else if @artistID = 0 /*and  @genreID = 0 and @ratingID = 0 */ and @filetypeID = 0
		BEGIN
			select songID, SongName, FiletypeID
				from Songs
				where SongID in (select SongID--//meets partial name requirment
									From Songs
									where SongName Like('%'+@pSongName+'%'))
					and SongID in (select SongID--//meets genre requirment
									from GenresToSongs 
									where GenreID = @genreID)
					and SongID in (select SongID--//meets rating requirment
									from RatingsToSongs 
									where RatingID = @ratingID)
		END
	else if /*@artistID = 0 and*/  @genreID = 0 /*and @ratingID = 0*/  and @filetypeID = 0
		BEGIN
			select songID, SongName, FiletypeID
				from Songs
				where SongID in (select SongID--//meets partial name requirment
									From Songs
									where SongName Like('%'+@pSongName+'%'))
					and SongID in (select SongID--//meets artist requirment
									from ArtistsToSongs 
									where ArtistID = @artistID)
					and SongID in (select SongID--//meets rating requirment
									from RatingsToSongs 
									where RatingID = @ratingID)
		END
	else if /*@artistID = 0 and  @genreID = 0 and*/ @ratingID = 0  and @filetypeID = 0
		BEGIN
			select songID, SongName, FiletypeID
				from Songs
				where SongID in (select SongID--//meets partial name requirment
									From Songs
									where SongName Like('%'+@pSongName+'%'))
					and SongID in (select SongID--//meets artist requirment
									from ArtistsToSongs 
									where ArtistID = @artistID)
					and SongID in (select SongID--//meets genre requirment
									from GenresToSongs 
									where GenreID = @genreID)
		END
	else if @artistID = 0 /*and  @genreID = 0 and @ratingID = 0  and @filetypeID = 0*/
		BEGIN
			select songID, SongName, FiletypeID
				from Songs
				where SongID in (select SongID--//meets partial name requirment
									From Songs
									where SongName Like('%'+@pSongName+'%'))
					and SongID in (select SongID--//meets genre requirment
									from GenresToSongs 
									where GenreID = @genreID)
					and SongID in (select SongID--//meets rating requirment
									from RatingsToSongs 
									where RatingID = @ratingID)
					and FiletypeID = @filetypeID
		END
	else if /*@artistID = 0 and*/  @genreID = 0 /*and @ratingID = 0  and @filetypeID = 0*/
		BEGIN
			select songID, SongName, FiletypeID
				from Songs
				where SongID in (select SongID--//meets partial name requirment
									From Songs
									where SongName Like('%'+@pSongName+'%'))
					and SongID in (select SongID--//meets artist requirment
									from ArtistsToSongs 
									where ArtistID = @artistID)
					and SongID in (select SongID--//meets rating requirment
									from RatingsToSongs 
									where RatingID = @ratingID)
					and FiletypeID = @filetypeID
		END
	else if /*@artistID = 0 and*/  /*@genreID = 0 and*/ @ratingID = 0  /*and @filetypeID = 0*/
		BEGIN
			select songID, SongName, FiletypeID
				from Songs
				where SongID in (select SongID--//meets partial name requirment
									From Songs
									where SongName Like('%'+@pSongName+'%'))
					and SongID in (select SongID--//meets artist requirment
									from ArtistsToSongs 
									where ArtistID = @artistID)
					and SongID in (select SongID--//meets genre requirment
									from GenresToSongs 
									where GenreID = @genreID)
					and FiletypeID = @filetypeID
		END
	else if /*@artistID = 0 and*/  /*@genreID = 0 and*/ /*@ratingID = 0  and*/ @filetypeID = 0
		BEGIN
			select songID, SongName, FiletypeID
				from Songs
				where SongID in (select SongID--//meets partial name requirment
									From Songs
									where SongName Like('%'+@pSongName+'%'))
					and SongID in (select SongID--//meets artist requirment
									from ArtistsToSongs 
									where ArtistID = @artistID)
					and SongID in (select SongID--//meets genre requirment
									from GenresToSongs 
									where GenreID = @genreID)
					and SongID in (select SongID--//meets rating requirment
									from RatingsToSongs 
									where RatingID = @ratingID)
		END
	else /*@artistID = 0 and @genreID = 0 and @ratingID = 0  and @filetypeID = 0*/
		BEGIN
			select songID, SongName, FiletypeID
				from Songs
				where SongID in (select SongID--//meets partial name requirment
									From Songs
									where SongName Like('%'+@pSongName+'%'))
					and SongID in (select SongID--//meets artist requirment
									from ArtistsToSongs 
									where ArtistID = @artistID)
					and SongID in (select SongID--//meets genre requirment
									from GenresToSongs 
									where GenreID = @genreID)
					and SongID in (select SongID--//meets rating requirment
									from RatingsToSongs 
									where RatingID = @ratingID)
					and FiletypeID = @filetypeID--//meets filetype requirmnt
		END
	return
go

--//deletes a song based on songID
create procedure deleteSong(@songID int = null) as
	delete
		from Songs
		where SongID = @songID
go

--//creates a new instance of a song 
create procedure createSong(@name varchar(100) = null, @filetypeID int = null) as
	if @name = null or @filetypeID = null
		raiserror('Missing parameter(s), need song name and filetypeID to create a new song', 16, 1)
	else
		BEGIN
			set @name = REPLACE(@name , '____', ' ')
			Insert into Songs (SongName, FiletypeID) values(@name, @filetypeID)
			Select SongID, SongName, FiletypeID 
				from Songs
				where SongID = @@IDENTITY 
		END
	return
go

--//update a song's name and filetype based on its SongID
create procedure updateSong(@songID int = null, @name varchar(100) = null, @filetypeID int = null) as
	if @songID = null or @name = null or @filetypeID = null
		raiserror('Missing parameter(s), songID, name and filetype are needed to update song. ', 16, 1)
	else
		BEGIN
			set @name = REPLACE(@name , '____', ' ')
			Update Songs set SongName = @name, FiletypeID = @filetypeID 
				where SongID = @songID

			if @@ROWCOUNT = 0 or not EXISTS(select * from Songs where SongID = @songID) 
				raiserror('no rows were affected in update', 16, 1)

			select SongID, SongName, FiletypeID from Songs where SongID = @songID
		END
	return
go
-----------------------------------------------------------------------
