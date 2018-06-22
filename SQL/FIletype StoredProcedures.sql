--// these are all th stored procedures that directly querry, add, remove or update Filetypes
use MusicClassificationDatabase
go

drop procedure AddFiletype
drop procedure fetchFiletypes
drop procedure UpdateFiletype
drop procedure DeleteFiletype
drop procedure fetchFiletypeDescription
drop procedure DeleteFiletype
drop procedure fetchFiletypeByPartial
go
--//use Alter to change a procedure or table

--//creates a new filetype
Create procedure AddFiletype(@FiletypeName varchar(100) = null) as
	if @FiletypeName = null
		raiserror('Missing parameter, filetype name required to create a filetype.', 16, 1)
	else
		BEGIN
			insert into Filetype (filetype) values (@FiletypeName)
			select FiletypeID, Filetype 
				from Filetype 
				where filetypeID = @@Identity
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
			select FiletypeID, Filetype
				from Filetype
				where filetypeID = @FiletypeID
			if @@ROWCOUNT = 0
				raiserror('no filetypes have this ID', 16, 1)
		END
return
go

--//searches for a filetype containing the partial Filetype string
create procedure fetchFiletypeByPartial(@partialFiletype varchar(50) = null) as
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


Create procedure DeleteFiletype(@FiletypeID int = null) as
	if @FiletypeID = null
		raiserror('Missing Parameter, need filetype ID to delete filetype.', 16, 1)
	else if  EXISTS(select * From Songs where FiletypeID = @FiletypeID)
		raiserror('Filetype is currently being used and cannot be deleted', 16, 1)
	else
		BEGIN
			Delete From Filetype
				where filetypeID = @FiletypeID
			if @@ROWCOUNT = 0
				raiserror('Delete Failed, Nothing was deleted.', 16, 1)
		END
return
go

create procedure UpdateFiletype(@FiletypeID int = null, @Filetype varchar(100) = null) as
	if @Filetype = null or @FiletypeID = null
		raiserror('Missing Parameter(s), need filetype id and filetype name to update filetype', 16, 1)
	else if not Exists(select * from Filetype where filetypeID = @FiletypeID)
		raiserror('Filetype does not exist, pleas cancel update and refresh list to reselect the filetype', 16, 1)
	else 
		BEGIN
			Update Filetype
				set filetype = @Filetype
				where FiletypeID = @FiletypeID
			if @@ROWCOUNT = 0
				raiserror('Update Failed, No rows affected. Please refresh list to ensure filetype still exists', 16, 1)
		END
return 
go