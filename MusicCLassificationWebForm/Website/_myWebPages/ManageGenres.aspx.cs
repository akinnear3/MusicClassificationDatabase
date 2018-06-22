using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using MusicDatabase.System.BLL;
using MusicDatabase.System.Data;

public partial class _myWebPages_ManageGenres : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        Message.Text = "";

        if (Page.IsPostBack)
        {

        }
        else
        {
            LoadData();
        }
    }

    /// <summary>
    /// gets the innermost exception of an exception
    /// </summary>
    /// <param name="ex"></param>
    /// <returns></returns>
    private Exception GetInnerException(Exception ex)
    {
        while (ex.InnerException != null)
        {
            ex = ex.InnerException;
        }
        return ex;
    }

    /// <summary>
    /// loads the gridview with all of the genres
    /// </summary>
    protected void LoadData()
    {
        Genres_Gridview.DataBind();
    }

    /// <summary>
    /// changes the buttons and label to match wheather or not an Artist is being updated
    /// (true is for update, false is for creating new)
    /// </summary>
    protected void ChangeEditMode(bool isUpdating, string name, string ID)
    {
        //change button to 'create new artist' layout
        UpdateGenreButton.Visible = isUpdating;
        AddGenreButton.Visible = !isUpdating;
        CancelUpdateButton.Visible = isUpdating;

        //change the label's text
        GenreNameLabel.Text = isUpdating ? "update Genre" : "new Genre";

        //change or clear info
        GenreName.Text = name;
        UpdatingGenreID.Text = ID;
    }

    protected void Genres_Gridview_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        //collect the rowIndex
        int row = (int)Convert.ChangeType(e.CommandArgument, TypeCode.Int32);

        //collect the controllers
        Label GenreIDController = (Label)Genres_Gridview.Rows[row].FindControl("GenreID");
        Label GenreNameController = (Label)Genres_Gridview.Rows[row].FindControl("Genre");

        #region Delete
        if (e.CommandName == "Delete")
        {
            e.Handled = true;
            try
            {
                GenreController gc = new GenreController();

                //delete the Genre
                gc.DeleteGenre(int.Parse(GenreIDController.Text));

                //reload the data
                LoadData();
            }
            catch (Exception ex)
            {
                Message.Text = GetInnerException(ex).Message;
            }
        }
        else if (e.CommandName == "Edit")
        {
            e.Handled = true;
            ChangeEditMode(true, GenreNameController.Text, GenreIDController.Text);
        }
        #endregion
    }



    protected void ClearButton_Click(object sender, EventArgs e)
    {
        SearchGenreName.Text = "";
        LoadData();
    }

    protected void SearchButton_Click(object sender, EventArgs e)
    {
        LoadData();
    }

    protected void AddGenreButton_Click(object sender, EventArgs e)
    {
        #region My validation to ensure a name is presented for the genre
        string name = GenreName.Text.Trim();
        if (string.IsNullOrEmpty(name))
        {
            //make it invalid so it trips the validation
            GenreName.Text = "!!!Invalid_!_Name!!!";
            CompareValidator1.IsValid = false;
            Page.Validate();

            //return the text to empty
            GenreName.Text = "";
        }
        #endregion
        if (Page.IsValid)
        {
            try
            {
                GenreController ac = new GenreController();
                ac.AddGenre(GenreName.Text);
                LoadData();
            }
            catch (Exception ex)
            {
                Message.Text = GetInnerException(ex).Message;
            }
        }
    }

    protected void UpdateGenreButton_Click(object sender, EventArgs e)
    {
        #region My validation to ensure a name is presented for the genre
        string name = GenreName.Text.Trim();
        if (string.IsNullOrEmpty(name))
        {
            //make it invalid so it trips the validation
            GenreName.Text = "!!!Invalid_!_Name!!!";
            CompareValidator1.IsValid = false;
            Page.Validate();

            //return the text to empty
            GenreName.Text = "";
        }
        #endregion

        if (Page.IsValid)
        {
            try
            {
                GenreController gc = new GenreController();
                gc.UpdateGenre(int.Parse(UpdatingGenreID.Text), GenreName.Text);
                LoadData();
                Message.Text = "Genre of ID " + UpdatingGenreID.Text + " has sucessfuly been renamed as " + GenreName.Text;

                ChangeEditMode(false, "", "-1");
            }
            catch (Exception ex)
            {
                Message.Text = GetInnerException(ex).Message;
            }

        }
    }

    protected void CancelUpdateButton_Click(object sender, EventArgs e)
    {
        ChangeEditMode(false, "", "-1");
    }
}