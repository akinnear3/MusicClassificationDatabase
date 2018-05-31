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

    protected void Genres_Gridview_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "Delete")
        {
            e.Handled = true;
            try
            {
                GenreController gc = new GenreController();

                //collect the rowIndex
                int row = (int)Convert.ChangeType(e.CommandArgument, TypeCode.Int32);

                //collect the controllers
                Label GenreIDController = (Label)Genres_Gridview.Rows[row].FindControl("GenreID");

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
    }

    private Exception GetInnerException(Exception ex)
    {
        while (ex.InnerException != null)
        {
            ex = ex.InnerException;
        }
        return ex;
    }

    /// <summary>
    /// loads the gridview with all of the songs
    /// </summary>
    protected void LoadData()
    {
        Genres_Gridview.DataBind();
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