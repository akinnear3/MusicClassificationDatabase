using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using MusicDatabase.System.BLL;
using MusicDatabase.System.DAL;
using MusicDatabase.System.Data;
using System.Data;

public partial class _myWebPages_SearchDatabase : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        Message.Text = "";

        if (Page.IsPostBack)
        {

        }
        else
        {
            EditingSongID.Text = "-1";
            LoadAllSearchData();
        }
    }

    private void LoadAllSearchData()
    {
        try
        {
            SongController s = new SongController();
            DataTable t = s.fetchAllSongs();
            SearchInfo_GridView.DataSource = t;
            SearchInfo_GridView.DataBind();
            
        }
        catch (Exception ex)
        {
            Message.Text = GetInerException(ex).Message;
        }
    }

    private void LoadSearchData()
    {
        try
        {
            string partialName = SearchSongName.Text;
            if (string.IsNullOrEmpty(partialName))
            {
                partialName = "__Nothing__";
            }
            else
            {
                //temp for spaces
                partialName = partialName.Replace(" ", "_re_plac_ing_");
            }

            int FiletypeID = int.Parse(SearchFiletypeDDL.SelectedValue);
            int GenresID = int.Parse(SearchGenreDDL.SelectedValue);
            int RatingID = int.Parse(SearchRatingDDL.SelectedValue);
            int ArtistsID = int.Parse(SearchArtistDDL.SelectedValue);


            SongController s = new SongController();
            DataTable t = s.fetchSongs_WithRestrictions(partialName, GenresID, FiletypeID, RatingID, ArtistsID);
            SearchInfo_GridView.DataSource = t;
            SearchInfo_GridView.DataBind();

        }
        catch (Exception ex)
        {
            Message.Text = GetInerException(ex).Message;
        }
    }

    Exception GetInerException(Exception ex)
    {
        while(ex.InnerException != null)
        {
            ex = ex.InnerException;
        }
        return ex;
    }



    protected void RemoveSong(int songID)
    {
        try
        {
            SongController s = new SongController();
            s.DeleteSong(songID);
            Message.Text = "Sucessfull method call " + songID;
        }
        catch (Exception ex)
        {
            Message.Text = GetInerException(ex).Message;
        }
        LoadAllSearchData();
    }

    protected void SearchInfo_GridView_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        //make sure the command exists and isn't page related
        if (!string.IsNullOrEmpty(e.CommandName) && e.CommandName.ToUpper() != "PAGE")
        {
            //collect the row number / index number
            int index = Convert.ToInt32(e.CommandArgument);

            //this retreives the row itself...
            GridViewRow row = SearchInfo_GridView.Rows[index];

            //gather the information into variables so that its easly accessed
            var SongIDControl = (Label)row.FindControl("SongID");
            var SongNameControl = (Label)row.FindControl("SongName");
            var FiletypeIDControl = (Label)row.FindControl("FiletypeID");
            var FiletypeControl = (Label)row.FindControl("Filetype");
            var GenresControl = (Label)row.FindControl("Genres");
            var RatingsControl = (Label)row.FindControl("Ratings");
            var ArtistsControl = (Label)row.FindControl("Artists");


            if (e.CommandName == "Delete")
            {
                e.Handled = true;
                try
                {
                    Message.Text = SongIDControl.Text;
                    Message.Text += " " + SongNameControl;
                    RemoveSong(int.Parse(SongIDControl.Text));
                }
                catch (Exception ex)
                {
                    Message.Text = GetInerException(ex).Message;

                }
                LoadAllSearchData();
            }
            else if(e.CommandName == "Edit")
            {
                e.Handled = true;
                //change the view to edit
                SearchDatabase_Multiview.ActiveViewIndex = 1;
                EditingSongID.Text = SongIDControl.Text;
                LoadEditData();
            }

        }
    }

    protected void TabMenu_MenuItemClick(object sender, MenuEventArgs e)
    {
        int index = Int32.Parse(e.Item.Value);
        SearchDatabase_Multiview.ActiveViewIndex = index;
        if(index == 0)
        {
            LoadAllSearchData();
        }
        else if(index == 1)
        {
            EditingSongID.Text = "-1";
            LoadEditData();
        }
    }

    private void LoadEditData()
    {
        ArtistToSongController atos = new ArtistToSongController();
        FiletypeController fc = new FiletypeController();
        GenreToSongController gtos = new GenreToSongController();
        RatingToSongController rtos = new RatingToSongController();
        SongController sc = new SongController();

        try
        {
            //reset the ddl so that its on the first one which is 'Select...'
            //manualy adding all the rows so that Select... is the first one and Editing FiletypeDDL doesn't get stacking data
            DataTable t = new DataTable();
            t.Columns.Add("FiletypeID");
            t.Columns.Add("Filetype");
            t.Rows.Add(new string[] { "0", "Select..." });
            foreach (DataRow dr in fc.GetFiletypes().Rows)
            {
                t.Rows.Add(new string[] { dr.Field<int>("FiletypeID").ToString(), dr.Field<string>("Filetype")});
            }

            EditingFiletypeDDL.DataSource = t;
            EditingFiletypeDDL.DataTextField = "Filetype";
            EditingFiletypeDDL.DataValueField = "FiletypeID";
            EditingFiletypeDDL.DataBind();

            //no song selected
            if (EditingSongID.Text == "-1")
            {
                //clear the song information
                EditingSongName.Text = "";

                //make sure its on 'select'
                EditingFiletypeDDL.SelectedIndex = 0;

                //make sure that all of the editing gridviews show emty if there aren't any
                EditingArtists_GridView.DataBind();
                EditingRatings_GridView.DataBind();
                EditingGenres_GridView.DataBind();

                //determine which button will be used on the edit/add tab
                Update_SongNameAndFiletype.Visible = false;
                Create_NewSong.Visible = true;

            }
            //a song is being edited
            else
            {
                int songid = int.Parse(EditingSongID.Text);
                DataTable songT = sc.fetchSong(songid);
                EditingSongName.Text = songT.Rows[0].Field<string>("SongName");
                //make sure its on the right value
                EditingFiletypeDDL.SelectedValue = songT.Rows[0].Field<int>("FiletypeID").ToString();

                #region Load and Bind Artists
                DataTable artistT = atos.GetArtistToSongInfo(songid);
                EditingArtists_GridView.DataSource = artistT;
                EditingArtists_GridView.DataBind();
                #endregion

                #region Load and Bind Ratings
                DataTable ratingT = rtos.GetRatingToSongInfo(songid);
                EditingRatings_GridView.DataSource = ratingT;
                EditingRatings_GridView.DataBind();
                #endregion

                #region Load and Bind Genres

                DataTable genreT = gtos.GetGenreToSongInfo(songid);
                EditingGenres_GridView.DataSource = genreT;
                EditingGenres_GridView.DataBind();
                #endregion

                //set the update button to being visable, and turn the add/create button invisable
                Update_SongNameAndFiletype.Visible = true;
                Create_NewSong.Visible = false;
            }
            EditingFiletypeDDL.DataBind();
        }
        catch(Exception ex)
        {
            Message.Text = GetInerException(ex).ToString();
        }
       
    }

    /// <summary>
    /// this is for removing and viewing genres of the song that is currently being edited
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void EditingGenres_GridView_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if(e.CommandName == "Delete")
        {
            e.Handled = true;
            int index = Convert.ToInt32(e.CommandArgument);
            Label genreIDController = (Label)EditingGenres_GridView.Rows[index].FindControl("EditingGenreID");
            GenreToSongController gtos = new GenreToSongController();
            try
            {
                gtos.RemoveReference(int.Parse(EditingSongID.Text), int.Parse(genreIDController.Text));
                LoadEditData();
            }
            catch(Exception ex)
            {
                Message.Text = GetInerException(ex).ToString();
            }

        }
    }

    /// <summary>
    /// this is for removing and viewing raitings of the song that is currently being edited
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void EditingRatings_GridView_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "Delete")
        {
            e.Handled = true;
            int index = Convert.ToInt32(e.CommandArgument);
            Label ratingIDController = (Label)EditingRatings_GridView.Rows[index].FindControl("EditingRatingID");
            RatingToSongController rtos = new RatingToSongController();
            try
            {
                rtos.RemoveReference(int.Parse(EditingSongID.Text), int.Parse(ratingIDController.Text));
                LoadEditData();
            }
            catch (Exception ex)
            {
                Message.Text = GetInerException(ex).ToString();
            }

        }
    }
    /// <summary>
    /// this is for removing and viewing genres of the song that is currently being edited
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void EditingArtists_GridView_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "Delete")
        {
            e.Handled = true;
            int index = Convert.ToInt32(e.CommandArgument);
            Label artistIDController = (Label)EditingArtists_GridView.Rows[index].FindControl("EditingArtistID");
            ArtistToSongController atos = new ArtistToSongController();
            try
            {
                atos.RemoveReference(int.Parse(EditingSongID.Text), int.Parse(artistIDController.Text));
                LoadEditData();
            }
            catch (Exception ex)
            {
                Message.Text = GetInerException(ex).ToString();
            }

        }
    }

    /// <summary>
    /// this button clears the information stored on the search buttons. 
    /// By claring/resseting their information there are no search parameters/restirctions.
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void ClearSearParamsButton_Click(object sender, EventArgs e)
    {
        SearchSongName.Text = "";
        //the ddl at 0 will indicate 'any' because 0 tells the search function not to include that restriction
        SearchFiletypeDDL.SelectedIndex = 0;
        SearchGenreDDL.SelectedIndex = 0;
        SearchRatingDDL.SelectedIndex = 0;
        SearchArtistDDL.SelectedIndex = 0;
    }

    /// <summary>
    /// this takes in all of the parameters from the search and calls the search function to retreive and load in the search data
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void SearchDatabaseButton_Click(object sender, EventArgs e)
    {
        LoadSearchData();
    }

    /// <summary>
    /// this is for the 'create song' button and creates a new song.
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void Create_NewSong_Click(object sender, EventArgs e)
    {
        try
        {
            string name = EditingSongName.Text;
            int filetypeID = int.Parse(EditingFiletypeDDL.SelectedValue);

            if (string.IsNullOrEmpty(name.Trim()))
            {
                Message.Text += "plaes specify a name, song name is required. ";
            }
            if (filetypeID == 0)
            {
                Message.Text += "please select a filetype, a filetype is required. ";
            }

            //there has been no error so far, allow it to process the request
            if (String.IsNullOrEmpty(Message.Text.Trim()))
            {
                SongController sc = new SongController();
                int newID = sc.CreateSong(name, filetypeID);
                EditingSongID.Text = newID.ToString();
                LoadEditData();
            }

        }
        catch (Exception ex)
        {
            Message.Text = GetInerException(ex).Message;
        }
    }

    /// <summary>
    /// this is for the 'update' button and updates the song that is currently being edited.
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void Update_SongNameAndFiletype_Click(object sender, EventArgs e)
    {
        
        try
        {
            string name = EditingSongName.Text;
            int filetypeID = int.Parse(EditingFiletypeDDL.SelectedValue);

            if (string.IsNullOrEmpty(name.Trim()))
            {
                Message.Text += "plaes specify a name, song name is required. ";
            }
            if (filetypeID == 0)
            {
                Message.Text += "please select a filetype, a filetype is required. ";
            }

            //there has been no error so far, allow it to process the request
            if (String.IsNullOrEmpty(Message.Text.Trim()))
            {
                SongController sc = new SongController();
                sc.UpdateSong(int.Parse(EditingSongID.Text), name, filetypeID);
                Message.Text = "Updated song to: " + EditingSongID.Text + " " + name + " filetype " + filetypeID.ToString();
                LoadEditData();
            }

        }
        catch (Exception ex)
        {
            Message.Text = GetInerException(ex).Message;
        }
    }

    /// <summary>
    /// this is the effect of pressing the 'add genre' button. 
    /// it adds the ddl genre as a reference to the song that is being updated
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void AddGenreButton_Click(object sender, EventArgs e)
    {
        int songID = int.Parse(EditingSongID.Text);
        if(songID != -1)
        {
            try
            {
                GenreToSongController gtos = new GenreToSongController();
                int genreID = int.Parse(GenreToAddDDL.SelectedValue);

                gtos.CreateReference(songID, genreID);
                LoadEditData();
            }
            catch (Exception ex)
            {
                Message.Text = GetInerException(ex).Message;
            }
        }
        else
        {
            Message.Text = "Song not yet created; pleas create the song before adding Genre(s)";
        }
        
    }

    /// <summary>
    /// this is the effect of pressing the 'add rating' button. 
    /// it adds the ddl rating as a reference to the song that is being updated
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void AddRatingButton_Click(object sender, EventArgs e)
    {
        int songID = int.Parse(EditingSongID.Text);
        if(songID != -1)
        {
            try
            {
                RatingToSongController rtos = new RatingToSongController();
                int ratingID = int.Parse(RatingToAddDDL.SelectedValue);

                rtos.CreateReference(songID, ratingID);
                LoadEditData();
            }
            catch (Exception ex)
            {
                Message.Text = GetInerException(ex).Message;
            }
        }
        else
        {
            Message.Text = "Song not yet created; pleas create the song before adding Rating(s)";
        }
       
    }

    /// <summary>
    /// this is the effect of pressing the 'add artist' button. 
    /// it adds the ddl artist as a reference to the song that is being updated
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void AddArtistButton_Click(object sender, EventArgs e)
    {
        int songID = int.Parse(EditingSongID.Text);
        if(songID != -1)
        {
            try
            {
                ArtistToSongController rtos = new ArtistToSongController();
                int artistID = int.Parse(ArtistToAddDDL.SelectedValue);

                rtos.CreateReference(songID, artistID);
                LoadEditData();
            }
            catch (Exception ex)
            {
                Message.Text = GetInerException(ex).Message;
            }
        }
        else
        {
            Message.Text = "Song not yet created; pleas create the song before adding Artist(s)";
        }
       
    }
}