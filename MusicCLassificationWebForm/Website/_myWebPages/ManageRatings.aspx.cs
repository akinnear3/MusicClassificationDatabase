using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using MusicDatabase.System.BLL;
using MusicDatabase.System.Data;

public partial class _myWebPages_ManageRatings : System.Web.UI.Page
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

    protected void Ratings_Gridview_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "Delete")
        {
            e.Handled = true;
            try
            {
                RatingController gc = new RatingController();

                //collect the rowIndex
                int row = (int)Convert.ChangeType(e.CommandArgument, TypeCode.Int32);

                //collect the controllers
                Label RatingIDController = (Label)Ratings_Gridview.Rows[row].FindControl("RatingID");

                //delete the Rating
                gc.DeleteRating(int.Parse(RatingIDController.Text));

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
        Ratings_Gridview.DataBind();
    }


    protected void ClearButton_Click(object sender, EventArgs e)
    {
        SearchRatingName.Text = "";
        LoadData();
    }

    protected void SearchButton_Click(object sender, EventArgs e)
    {
        LoadData();
    }

    protected void AddRatingButton_Click(object sender, EventArgs e)
    {
        try
        {
            RatingController ac = new RatingController();
            ac.AddRating(RatingName.Text);
            LoadData();
        }
        catch (Exception ex)
        {
            Message.Text = GetInnerException(ex).Message;
        }
    }
}