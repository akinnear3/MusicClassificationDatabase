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
    /// loads the gridview with all of the ratings
    /// </summary>
    protected void LoadData()
    {
        Ratings_Gridview.DataBind();
    }
    /// <summary>
    /// changes the buttons and label to match wheather or not an rating is being updated
    /// (true is for update, false is for creating new)
    /// </summary>
    protected void ChangeEditMode(bool isUpdating, string ratingName, string ratingID)
    {
        //change button to 'create new artist' layout
        UpdateRatingButton.Visible = isUpdating;
        AddRatingButton.Visible = !isUpdating;
        CancelUpdateButton.Visible = isUpdating;

        //change the label's text
        RatingNameLabel.Text = isUpdating ? "update Rating name" : "new Rating name";

        //change or clear info
        RatingName.Text = ratingName;
        UpdatingRatingID.Text = ratingID;
    }


    protected void Ratings_Gridview_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        //collect the rowIndex
        int row = (int)Convert.ChangeType(e.CommandArgument, TypeCode.Int32);

        //collect the controllers
        Label RatingIDController = (Label)Ratings_Gridview.Rows[row].FindControl("RatingID");
        Label RatingNameController = (Label)Ratings_Gridview.Rows[row].FindControl("rating");

        #region Delete command
        if (e.CommandName == "Delete")
        {
            e.Handled = true;
            try
            {
                RatingController gc = new RatingController();
                              
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
        #endregion
        #region Edit command
        else if (e.CommandName == "Edit")
        {
            e.Handled = true;
            ChangeEditMode(true, RatingNameController.Text, RatingIDController.Text);
        }
        #endregion
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
        #region My validation to ensure a name is presented for the artist
        string name = RatingName.Text.Trim();
        if (string.IsNullOrEmpty(name))
        {
            RatingName.Text = "!!!Invalid_!_Name!!!";
            CompareValidator1.IsValid = false;
            Page.Validate();
            RatingName.Text = "";
        }
        #endregion
        if (Page.IsValid)
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

    protected void UpdateRatingButton_Click(object sender, EventArgs e)
    {
        #region My validation to ensure a name is presented for the artist
        string name = RatingName.Text.Trim();
        if (string.IsNullOrEmpty(name))
        {
            RatingName.Text = "!!!Invalid_!_Name!!!";
            CompareValidator1.IsValid = false;
            Page.Validate();
            RatingName.Text = "";
        }
        #endregion
        if (Page.IsValid)
        {
            try
            {
                RatingController rc = new RatingController();
                rc.UpdateRating(int.Parse(UpdatingRatingID.Text), RatingName.Text);
                LoadData();
                Message.Text = "Rating of ID " + UpdatingRatingID.Text + " has sucessfuly been renamed as " + RatingName.Text;

                ChangeEditMode(false, "", "-1");
            }
            catch(Exception ex)
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