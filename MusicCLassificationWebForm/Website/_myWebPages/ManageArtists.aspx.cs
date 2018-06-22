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

    /// <summary>
    /// loads the gridview with all of the artits
    /// </summary>
    protected void LoadData()
    {
        try
        {
            Artists_Gridview.DataBind();
        }
        catch(Exception ex)
        {
            Message.Text = GetInnerException(ex).Message;
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
    /// changes the buttons and label to match wheather or not an Artist is being updated
    /// (true is for update, false is for creating new)
    /// </summary>
    /// <param name="isUpdatingArtist"></param>
    /// <param name="artistID"></param>
    /// <param name="artistName"></param>
    protected void ChangeEditMode(bool isUpdatingArtist, string artistName, string artistID)
    {
        //change button to 'create new artist' layout
        UpdateArtistButton.Visible = isUpdatingArtist;
        AddArtistButton.Visible = !isUpdatingArtist;
        CancelUpdateButton.Visible = isUpdatingArtist;

        //change the label's text
        ArtistNameLabel.Text = isUpdatingArtist? "update Artist name" : "new Artist name";

        //change or clear info
        ArtistName.Text = artistName;
        UpdatingArtistID.Text = artistID;
    }

    protected void Artists_Gridview_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        //collect the rowIndex
        int row = (int)Convert.ChangeType(e.CommandArgument, TypeCode.Int32);

        //collect the controllers
        Label artistIDController = (Label)Artists_Gridview.Rows[row].FindControl("ArtistID");
        Label artistNameController = (Label)Artists_Gridview.Rows[row].FindControl("Artist");

        #region Delete command
        if (e.CommandName == "Delete")
        {
            e.Handled = true;
            try
            {
                ArtistController ac = new ArtistController();

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
        #endregion
        #region Edit command
        if (e.CommandName == "Edit")
        {
            e.Handled = true;
            ChangeEditMode(true, artistNameController.Text, artistIDController.Text);
        }
        #endregion
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
        #region My validation to ensure a name is presented for the artist
        string name = ArtistName.Text.Trim();
        if (string.IsNullOrEmpty(name))
        {
            ArtistName.Text = "!!!Invalid_!_Name!!!";
            CompareValidator1.IsValid = false;
            Page.Validate();
            ArtistName.Text = "";
        }
        #endregion

        if (Page.IsValid)
        {
            try
            {
                ArtistController ac = new ArtistController();
                int newArtistID = ac.AddArtist(ArtistName.Text);
                LoadData();
                Message.Text = "Artist " + ArtistName.Text + " has sucessfuly been added with an ID of " + newArtistID;
            }
            catch (Exception ex)
            {
                Message.Text = GetInnerException(ex).Message;
            }
        }
       
    }

    protected void UpdateArtistButton_Click(object sender, EventArgs e)
    {
        #region My validation to ensure a name is presented for the artist
        string name = ArtistName.Text.Trim();
        if (string.IsNullOrEmpty(name))
        {
            ArtistName.Text = "!!!Invalid_!_Name!!!";
            CompareValidator1.IsValid = false;
            Page.Validate();
            ArtistName.Text = "";
        }
        #endregion

        if (Page.IsValid)
        {
            try
            {
                ArtistController ac = new ArtistController();
                ac.UpdateArtist(int.Parse(UpdatingArtistID.Text) , ArtistName.Text);
                LoadData();
                Message.Text = "Artist of ID " + UpdatingArtistID.Text + " has sucessfuly been renamed as " + ArtistName.Text;

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