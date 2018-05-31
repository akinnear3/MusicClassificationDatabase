--// these are all th stored procedures that directly querry, add, remove or update Ratings
use MusicClassificationDatabase
go


drop procedure RemoveRatingReferencesBySong
drop procedure fetchRatingBySongID
drop procedure fetchRatings
drop procedure DeleteRatingToSong
drop procedure AddRatingToSong
go


--//this deletes all references between ratings and a song based on the song that was passed in
create procedure RemoveRatingReferencesBySong (@SongID int = null) as
	Delete RatingsToSongs
		where SongID = @SongID
go


--//returns the rating and ratingID using RatingsToSongs as a makeshift array
create procedure fetchRatingBySongID(@SongID int = null) as
	if @SongID = null
		BEGIN
			raiserror('rating not supplied', 16, 1)
		END
	else
		BEGIN
			select r.RatingID, r.Rating, SongID
				from RatingsToSongs join Ratings r on r.RatingID = RatingsToSongs.RatingID
				where SongID = @SongID
		END
go


create procedure fetchRatings as
	select RatingID, Rating 
		from Ratings
go


create procedure DeleteRatingToSong(@SongID int = null, @RatingID int = null) as
	if @SongID = null or @ratingID = null 
		Raiserror('missing parameter(s). Deleting ratingToSong requires songID and RatingID', 16, 1)
	Delete From RatingsToSongs
		where RatingID = @ratingID and
				SongID = @SongID
	if @@ROWCOUNT = 0
		raiserror(' Delete Failed. No Rows Affected.', 16, 1)
return
go

--//create a reference between a rating and a song
create procedure AddRatingToSong(@songID int = null, @RatingID int = null) as
	if @RatingID = null or @songID = null
		raiserror('Missing Parameter(s). Pleas provide songID and RatingID to add a rating to song reference.', 16, 1)
	else
		BEGIN
			insert into RatingsToSongs(SongID, RatingID)  values(@songID, @RatingID)
		END
return
go

--//creates a new rating
create procedure AddRating(@RatingName varchar(100) = null) as
	if @RatingName = null
			raiserror('no rating provided', 16, 1)
		else
			BEGIN
				insert into Ratings(Rating) values (@RatingName)
			END
	return
go

--// search for ratings that meet the partial rating
create procedure searchRatings (@partialRating varchar(100) = null) as
	if @partialRating = null
		raiserror('Missing Parameter. partial Rating required to search Ratings', 16, 1)
	else if @partialRating = '__No_th_ing_'
		BEGIN 
			exec fetchRatings
		END
	else
		BEGIN
			select RatingID, Rating 
				from Ratings 
				where Rating like ('%' + @partialRating + '%')
		END
return
go

--//deletes a Rating based on rating ID
create procedure DeleteRating(@RatingID int = null) as
	if @RatingID = null
		raiserror('no RatingID supplied', 16, 1)
	else if EXISTS(select RatingID from RatingsToSongs where RatingID = @RatingID)
		raiserror('Rating is currently being used and cannot be deleted', 16, 1)
	else 
		BEGIN
			Delete from Ratings	
				where RatingID = @RatingID
		END
go
------------------------------------------------------------------------------------------



create procedure UpdateRating(@RatingID int = null, @Ratingname varchar = null) as

go






create procedure fetchRatingToSongs as
	select RatingID, SongID 
		from RatingsToSongs
go

create procedure UpdateRatingToSong(@RatingID int = null, @SongID int = null) as

go






go

