
--//this holds all of the procedures for artists and artistsToSongs
use MusicClassificationDatabase
go

drop procedure fetchArtistsBySongID
drop procedure RemoveArtistReferencesBySong
drop procedure fetchArtists
drop procedure AddArtist
drop procedure DeleteArtist
drop procedure UpdateArtist
drop procedure fetchArtistToSongs
drop procedure DeleteArtistToSong
drop procedure AddArtistToSong
drop procedure searchArtists
go


--//returns the artist name and ID by using ArtistsToSongs as a makeshift array
create procedure fetchArtistsBySongID(@songID int = null) as
	if @songID = null
		BEGIN
			raiserror('the song id has not been supplied', 16, 1)
		END
	else 
		BEGIN
			select Artists.ArtistID, Artists.Name, SongID
				from ArtistsToSongs join Artists on Artists.ArtistID = ArtistsToSongs.ArtistID
				where ArtistsToSongs.SongID = @songID
		END
go

--//adds a new artist using the name
create procedure AddArtist(@artistName varchar(100) = null) as
	if @artistName = null
		raiserror('no artiat name provided', 16, 1)
	else if EXISTS(select * from Artists where Name = @artistName)
		raiserror('Artist Already Exists. Please make the name unique.', 16, 1)
	else
		BEGIN
			insert into Artists (Name) values (@artistName)
			select ArtistID, name from Artists where ArtistID = @@IDENTITY
		END
return
go

--//gets all of the artists
create procedure fetchArtists as
	select ArtistID, Name
		from Artists
go

--//updates an artist
Create procedure UpdateArtist(@artistID int = null, @artistname varchar(100) = null) as
	if @artistname = null
		raiserror('Missing Parameter(s). ID and name required to update artist', 16, 1)
	else if EXists(select * from Artists where Name = @artistname)
		raiserror('Update Canceled; Artist Already exists. Please chose a Unique name', 16, 1)
	else
		BEGIN
			UPDATE Artists 
				set Name = @artistname
				where ArtistID = @artistID
			if @@ROWCOUNT = 0
				raiserror('Update Failed, No rows affected. Please refresh list to ensure it still exists', 16, 1)
		END
return
go

--//deletes an artist
create procedure DeleteArtist(@artistID int = null) as
	if @artistID = null
		raiserror('no artist supplied', 16, 1)
	else if EXISTS(select artistID from ArtistsToSongs where ArtistID = @artistID)
		raiserror('artist is currently being used and cannot be deleted', 16, 1)
	else 
		BEGIN
			Delete from Artists	
				where ArtistID = @artistID
		END
go

create procedure RemoveArtistReferencesBySong(@SongID int = null) as
	Delete 
		from ArtistsToSongs
		where SongID = @SongID
go


create procedure fetchArtistToSongs as
	select ArtistID, SongID 
		from ArtistsToSongs
return
go

--//delete one reference between Artists and Songs
create procedure DeleteArtistToSong(@SongID int = null,  @artistID int = null) as
	if @SongID = null or @artistID = null 
		Raiserror('missing parameter(s). Deleting artistToSong requires songID and ArtistID', 16, 1)
	Delete From ArtistsToSongs
		where ArtistID = @artistID and
				SongID = @SongID
	if @@ROWCOUNT = 0
		raiserror(' Delete Failed. No Rows Affected.', 16, 1)
return
go


--//create a reference between a artist and a song
create procedure AddArtistToSong(@songID int = null, @artistID int = null) as
	if @artistID = null or @songID = null
		raiserror('Missing Parameter(s). Pleas provide songID and artistID to add a Artist to song reference.', 16, 1)
	else
		BEGIN
			insert into ArtistsToSongs(SongID, ArtistID)  values(@songID, @artistID)
		END
return
go

Create procedure searchArtists(@partialName varchar(100) = null) as
	if @partialName = null
		raiserror('Missing Parameter. partial name required to search artists', 16, 1)
	else if @partialName = '__Nothing__'
		Exec fetchArtists
	else
		BEGIN
			set @partialName = REPLACE(@partialName, '__s_pa_ce__', ' ')
			select ArtistID, Name 
				from Artists 
				where Name like ('%' + @partialName + '%')
		END
return 
go


--//returns a artist to song if it exists
Create procedure CheckArtistToSong(@songID int = null, @artistID int = null) as
	if @songID = null or @artistID = null
		raiserror('Missing Parameter(s). Check Artist - Song Failed.', 16, 1)
	else
		BEGIN 
			select SongID, ArtistID 
				from ArtistsToSongs
				where ArtistID = @artistID and SongID = @songID
		END
return
go

-------------------------------------------------------------------------------------------------------


