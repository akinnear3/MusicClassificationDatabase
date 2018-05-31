use MusicClassificationDatabase
go

--//these are test filetypes
insert into Filetype (filetype) values('test filetype')
insert into Filetype (filetype) values('test filetype 2')
select * from Filetype

--//these are test songs
insert into Songs (SongName, FiletypeID) values('testing songs', 1)
insert into Songs (SongName, FiletypeID) values('testing songs 2', 2)
insert into Songs (SongName, FiletypeID) values('testing songs 3', 2)
select * from Songs

--//these are test Genres
insert into Genres (genre) values('test genre')
insert into Genres (genre) values('test genre 2')
select * from Genres

insert into GenresToSongs (SongID, GenreID) values(6, 1)
insert into GenresToSongs (SongID, GenreID) values(6, 2)
insert into GenresToSongs (SongID, GenreID) values(7, 1)
insert into GenresToSongs (SongID, GenreID) values(7, 2)
insert into GenresToSongs (SongID, GenreID) values(8, 1)
insert into GenresToSongs (SongID, GenreID) values(8, 2)
insert into GenresToSongs (SongID, GenreID) values(9, 1)
insert into GenresToSongs (SongID, GenreID) values(9, 2)
insert into GenresToSongs (SongID, GenreID) values(10, 1)
insert into GenresToSongs (SongID, GenreID) values(10, 2)
insert into GenresToSongs (SongID, GenreID) values(11, 2)
insert into GenresToSongs (SongID, GenreID) values(11, 1)
insert into GenresToSongs (SongID, GenreID) values(12, 2)
insert into GenresToSongs (SongID, GenreID) values(12, 2)
insert into GenresToSongs (SongID, GenreID) values(13, 1)
insert into GenresToSongs (SongID, GenreID) values(13, 2)
select * from GenresToSongs

--//these are test Ratings
insert into Ratings (Rating) values('test rating')
select * from Ratings

insert into RatingsToSongs (SongID, RatingID) values(6, 1)
insert into RatingsToSongs (SongID, RatingID) values(6, 2)
insert into RatingsToSongs (SongID, RatingID) values(7, 1)
insert into RatingsToSongs (SongID, RatingID) values(7, 2)
insert into RatingsToSongs (SongID, RatingID) values(8, 1)
insert into RatingsToSongs (SongID, RatingID) values(8, 2)
insert into RatingsToSongs (SongID, RatingID) values(9, 1)
insert into RatingsToSongs (SongID, RatingID) values(9, 2)
insert into RatingsToSongs (SongID, RatingID) values(10, 1)
insert into RatingsToSongs (SongID, RatingID) values(10, 2)
insert into RatingsToSongs (SongID, RatingID) values(11, 1)
insert into RatingsToSongs (SongID, RatingID) values(11, 2)
insert into RatingsToSongs (SongID, RatingID) values(12, 1)
insert into RatingsToSongs (SongID, RatingID) values(12, 2)
insert into RatingsToSongs (SongID, RatingID) values(13, 1)
insert into RatingsToSongs (SongID, RatingID) values(13, 2)
select * from RatingsToSongs

--these are test artists
insert into Artists (Name) values('test artist')
insert into Artists (Name) values('test artist 2')
select * from Artists

insert into ArtistsToSongs (SongID, ArtistID) values(6, 1)
insert into ArtistsToSongs (SongID, ArtistID) values(6, 2)
insert into ArtistsToSongs (SongID, ArtistID) values(7, 3)
insert into ArtistsToSongs (SongID, ArtistID) values(7, 1)
insert into ArtistsToSongs (SongID, ArtistID) values(8, 2)
insert into ArtistsToSongs (SongID, ArtistID) values(8, 3)
insert into ArtistsToSongs (SongID, ArtistID) values(9, 1)
insert into ArtistsToSongs (SongID, ArtistID) values(9, 2)
insert into ArtistsToSongs (SongID, ArtistID) values(10, 3)
insert into ArtistsToSongs (SongID, ArtistID) values(10, 1)
insert into ArtistsToSongs (SongID, ArtistID) values(11, 2)
insert into ArtistsToSongs (SongID, ArtistID) values(11, 3)
select * from ArtistsToSongs

