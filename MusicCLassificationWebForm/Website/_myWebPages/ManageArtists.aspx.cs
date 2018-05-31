using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using MusicDatabase.System;
using MusicDatabase.System.BLL;
using MusicDatabase.System.Data;

public partial class _myWebPages_ManageArtists : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        Message.Text = "";

        if (Page.IsPostBack)
        {

        }
        else
        {

        }

    }


    protected void Artists_Gridview_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if(e.CommandName == "Delete")
        {
            e.Handled = true;
            try
            {
                ArtistController ac = new ArtistController();

                //collect the rowIndex
                int row = (int) Convert.ChangeType(e.CommandArgument, TypeCode.Int32);

                //collect the controllers
                Label artistIDController = (Label)Artists_Gridview.Rows[row].FindControl("ArtistID");

                //delete the artist
                ac.DeleteArtist(int.Parse(artistIDController.Text));

                //Reload the data
                Artists_Gridview.DataBind();
            }
            catch(Exception ex)
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
        Artists_Gridview.DataBind();
    }

    
    protected void ClearButton_Click(object sender, EventArgs e)
    {
        SearchArtistName.Text = "";
        LoadData();
    }

    protected void SearchButton_Click(object sender, EventArgs e)
    {
        LoadData();
    }

    protected void AddArtistButton_Click(object sender, EventArgs e)
    {
        try
        {
            ArtistController ac = new ArtistController();
            ac.AddArtist(ArtistName.Text);
            LoadData();
        }
        catch(Exception ex)
        {
            Message.Text = GetInnerException(ex).Message;
        }
    }
}