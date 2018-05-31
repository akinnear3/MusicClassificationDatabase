Create Database MusicClassificationDatabase
go

use MusicClassificationDatabase
go

drop table ArtistsToSongs
drop table GenresToSongs
drop table RatingsToSongs
go

drop table Songs
drop table Artists
drop table Genres
drop table Ratings
drop table Filetype
go

Create table Artists
(
	ArtistID int Identity(1,1)		not null
		constraint PK_ArtistID Primary key clustered,
	Name varchar(100)				not null
)
Create table Genres
(
	GenreID int Identity(1,1)		not null
		constraint PK_GenreID Primary key clustered,
	genre varchar(50)				not null

)
Create table Ratings
(
	RatingID	int Identity(1, 1)	not null
		Constraint PK_RatingID Primary key clustered,
	Rating varchar(200)				not null
		Constraint  DF_Rating Default('none')
)
Create table Filetype
(
	filetypeID int Identity(1, 1)	not null
		constraint PK_filetypeID primary key clustered,
	filetype varchar(50)			not null 
)
go

Create table Songs
(
	SongID		int	Identity(0, 1)	not null
		Constraint PK_Songs Primary key clustered,
	SongName	varchar(100)		not null,
	FiletypeID	int					not null
		constraint FK_FiletypeID foreign key REFERENCES Filetype(filetypeID) 
)
go

Create table ArtistsToSongs
(
	ArtistID int not null
		constraint FK_ArtistsTOSongs_ArtistID References Artists(ArtistID),
	SongID int not null
		constraint FK_ArtistsTOSongs_SongID References Songs(SongID),
	constraint PK_ArtistsToSongs Primary key(SongID, ArtistID)
)
Create table GenresToSongs
(
	GenreID int not null
		constraint FK_GenresTOSongs_GenreID References Genres(GenreID),
	SongID int not null
		constraint FK_GenresTOSongs_SongID References Songs(SongID),
	constraint PK_GenresToSongs Primary key(SongID, GenreID)
)
Create table RatingsToSongs
(
	RatingID int not null
		constraint FK_RatingsTOSongs_RatingID References Ratings(RatingID),
	SongID int not null
		constraint FK_RatingsTOSongs_SongID References Songs(SongID),
	constraint PF_ArtistsToSongs Primary key(SongID, RatingID)
)
go


--//refferenced https://www.red-gate.com/simple-talk/sql/database-administration/arrays-in-sql-that-avoid-repeated-groups/
--//the idea is to have a refferenced ID to something (e.g. a song) and then an aditional refference for each part that has an 'array'. 
--the primary key is then given all of the ID's as a composite PK
--i'm guessing its used as a subquerry to get the correct list of IDs based of one ID. I think this is an 'array' in database language

Create Table MyArray
(
	i INTEGER NOT NULL CHECK (i BETWEEN 0 and 9),
	element INTEGER NOT NULL,
	PRIMARY KEY (i)
);
drop table MyArray
