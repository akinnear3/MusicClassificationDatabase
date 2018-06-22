using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using MusicDatabase.System.BLL;
using MusicDatabase.System.Data;
using MusicDatabase.System.DAL;

public partial class _myWebPages_ManageFiletypes : System.Web.UI.Page
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
    /// loads/reloads the gridview of filetypes
    /// </summary>
    protected void LoadData()
    {
        try
        {
            filetypes_Gridview.DataBind();
        }
        catch (Exception ex)
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
        while(ex.InnerException != null)
        {
            ex = ex.InnerException;
        }
        return ex;
    }
   
    private void ChangeEditMode(bool isUpdating, string filetypeID)
    {
        //change buttons to 'create new artist' layout
        UpdateFyletypeButton.Visible = isUpdating;
        AddFiletypeButton.Visible = !isUpdating;
        CancelUpdateButton.Visible = isUpdating;

        //change label's text
        FiletypeInputLabel.Text = isUpdating ? "update Filetype name" : "new Filetype name";

        //claer or change info
        FiletypeInput.Text = "";
        if (isUpdating)
        {
            try
            {
                FiletypeController fc = new FiletypeController();
                MusicDatabase_Filetype filetype = fc.fetchFiletypeByID(int.Parse(filetypeID));
                FiletypeInput.Text = filetype.filetype;
            }
            catch (Exception ex)
            {
                Message.Text = "Change edit mode failed. Could not edit filetype. Reason: " + GetInnerException(ex).Message;
            }
        }
       
        UpdatingFiletypeID.Text = filetypeID;
    }

    protected void filetypes_Gridview_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        int rowIndex = (int)Convert.ChangeType(e.CommandArgument, TypeCode.Int32);
        Label filetypeIDControll = (Label) filetypes_Gridview.Rows[rowIndex].FindControl("FiletypeID");
        #region delete command
        if (e.CommandName == "Delete")
        {
            e.Handled = true;
            try
            {
                FiletypeController fc = new FiletypeController();

                //delete filetype
                fc.DeleteFiletype(int.Parse(filetypeIDControll.Text));

                //reload data
                LoadData();
            }
            catch(Exception ex)
            {
                Message.Text = GetInnerException(ex).Message;
            }
        }
        #endregion
        #region edit command
        else if(e.CommandName == "Edit")
        {
            e.Handled = true;
            ChangeEditMode(true, filetypeIDControll.Text);
        }
        #endregion
    }



    protected void SearchButton_Click(object sender, EventArgs e)
    {
        //if (String.IsNullOrEmpty(SearchFiletype.Text.Trim()))
        //{
        //    SearchFiletype.Text = "";
        //}

        LoadData();

    }
 /// <summary>
    /// clars the search parameter and reloads the view
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void ClearButton_Click(object sender, EventArgs e)
    {
        SearchFiletype.Text = "";
        LoadData();
    }
 protected void AddFiletypeButton_Click(object sender, EventArgs e)
    {
        #region My validation to ensure a name is presented for the filetype
        string name = FiletypeInput.Text.Trim();
        if (string.IsNullOrEmpty(name))
        {
            //have it trigger the invalid validation
            FiletypeInput.Text = "!!!Invalid_!_Name!!!";
            CompareValidator1.IsValid = false;
            Page.Validate();

            //clar the text i put in
            FiletypeInput.Text = "";
        }
        #endregion
        try
        {
            FiletypeController fc = new FiletypeController();
            int newFtp = fc.AddFiletype(FiletypeInput.Text);
            LoadData();
            Message.Text = "Filetype " + FiletypeInput.Text + " has been sucessfuly been added with an ID of " + newFtp;
        }
        catch(Exception ex)
        {
            Message.Text = GetInnerException(ex).Message;
        }
    }

    protected void UpdateFyletypeButton_Click(object sender, EventArgs e)
    {
        #region My validation to ensure a name is presented for the filetype
        string name = FiletypeInput.Text.Trim();
        if (string.IsNullOrEmpty(name))
        {
            FiletypeInput.Text = "!!!Invalid_!_Name!!!";
            CompareValidator1.IsValid = false;
            Page.Validate();
            FiletypeInput.Text = "";
        }
        #endregion

        if (Page.IsValid)
        {
            try
            {
                FiletypeController fc = new FiletypeController();
                fc.UpdateFiletype(int.Parse(UpdatingFiletypeID.Text), FiletypeInput.Text);
                LoadData();
                Message.Text = "Filetype of ID " + UpdatingFiletypeID.Text + " has sucessfuly been renamed as " + FiletypeInput.Text;

                ChangeEditMode(false, "-1");
            }
            catch (Exception ex)
            {
                Message.Text = GetInnerException(ex).Message;
            }

        }
    }

    protected void CancelUpdateButton_Click(object sender, EventArgs e)
    {
        ChangeEditMode(false, "-1");
    }
  
}