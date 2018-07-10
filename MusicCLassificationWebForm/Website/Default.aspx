<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    
    <br />
    <br />
    <br />
    <div class="row">
            <h1 >Welcome to Music Classification Database</h1>
    </div>
    <br />

    <div class="row">
        <div style="padding:20px; background-color:lavender">
            <h2>How the notes are devided up</h2>
            <p>Notes on how to use this site as well as what doesn't work will be here on the main page. This page will be devided up into sections to discribe how this application works.</p>
        </div>
        <div style="padding:20px; background-color:lemonchiffon">
            <h2>What is this application's Goal?</h2>
            <p>
                the goals of this application was to both learn how to create an ASP.NET application where I specificaly code the interactions with the database 
                & to create a means of better sorting YouTube music videos (and other music video/song sources) into an easyer to manage system. (creating lots of folders wasn't good enough for me)
            </p>
        </div>
        <div style="padding:20px; background-color:lavender">
            <h2>How do I manage the songs?</h2>
            <p>
                songs can be added and searched for on the Seach Music Database page. 
                To create a song use the add new tab and enter the starting information. 
                Once the name and filetype has been specefied then you can associate Genres, Rating and Artists with the song.
            </p>
            <p>Existing songs can be edited or deleted using the appropriate buttons in the view</p>
            <p>the seach function works by using one or more of the possible criteria: 
                when you have a criteria specified press search to reload the view with the search.
                the Clear restirction clears the search and displayes all.
            </p>
        </div>
        <div style="padding:20px; background-color:lemonchiffon">
            <h2>How do I manage The artists, filetypes, genres and ratings?</h2>
            <p>
                For the artists, filetypes, genre, and ratings 
                they all have the same editing configuration and can be searched, created, edited or deleted in there respective Manage pages.
            </p>
        </div>
        <div style="padding:20px; background-color:lavender">
            <h2>Bugs and Problems I am currently working on</h2>
            <ul>      
               <li>All Clear... for now</li>
            </ul>
        </div>
        <div style="padding:20px; background-color:lemonchiffon">
            <h2>Future additions to this project</h2>
            <ul>      
                <li>
                    A reference to the song's location or hyperlink
                </li>
                <li>
                    Tell the filetype which program / how to open the file
                </li>
                <li>
                    Have the dataTable that is returned converted into a custom datatype.
                </li>
                <li>
                    I may change the information that is displayed in the [artist, rating, genre] drop down lists when updating a song. 
                    The change would be to remove items that have alreadyh been added to the song, and have a message if there are no [genre, artist, rating] that can be added.
                    (becaause all are already added or there arent any in the first place)
                </li>
            </ul>
        </div>
        <div style="padding:20px; background-color:lavender">
            <h2>Github Account & contact info</h2>
            <p>this application is one I have uploaded to my gitHub account akinnear3 (<a href="https://github.com/akinnear3/">https://github.com/akinnear3/</a>)</p>
            <p>For those who wish to contact me my profetional email is AlexDKinnear3@gmail.com</p>
        </div>
    </div>

</asp:Content>
