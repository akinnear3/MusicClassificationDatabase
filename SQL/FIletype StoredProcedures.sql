--// these are all th stored procedures that directly querry, add, remove or update Filetypes
use MusicClassificationDatabase
go

drop procedure AddFiletype
drop procedure fetchFiletypes
drop procedure UpdateFiletype
drop procedure DeleteFiletype
drop procedure fetchFiletypeDescription
drop procedure DeleteFiletype
go
--//use Alter to change a procedure or table

--//creates a new filetype
Create procedure AddFiletype(@FiletypeName varchar(100) = null) as
	if @FiletypeName = null
		raiserror('Missing parameter, filetype name required to create a filetype.', 16, 1)
	else
		BEGIN
			insert into Filetype (filetype) values (@FiletypeName)
		END
return
go

--//fetches all of the filetypes
create procedure fetchFiletypes as
	select filetypeID, filetype 
		from Filetype
go

--//fetches a filetype based on its FiletypeID
create procedure fetchFiletypeDescription (@FiletypeID int = null) as
	if @FiletypeID = null	
		raiserror('Missing Parameter, filetypeID needed to find filetype.', 16, 1)
	else
		BEGIN
			select Filetype
				from Filetype
				where filetypeID = @FiletypeID
			if @@ROWCOUNT = 0
				raiserror('no filetypes have this ID', 16, 1)
		END
return
go

--//searches for a filetype containing the partial Filetype string
create procedure fetchFiletypeByPartial(@partialFiletype varchar(100) = null) as
	if @partialFiletype = null	
		raiserror('missing parameter, partial filetype name required to search filetypes.', 16, 1)
	else if @partialFiletype = '__Nothing__'
		BEGIN
			exec fetchFiletypes
		END
	else
		BEGIN
			select FiletypeID, FIletype from Filetype where Filetype like ('%' + @partialFiletype + '%')
		END
return
go


create procedure DeleteFiletype(@FiletypeID int = null) as
	if @FiletypeID = null
		raiserror('Missing Parameter, need filetype ID to delete filetype.', 16, 1)
	else
		BEGIN
			Delete From Filetype
				where filetypeID = @FiletypeID
			if @@ROWCOUNT = 0
				raiserror('Delete Failed, Nothing was deleted.', 16, 1)
		END
return
go