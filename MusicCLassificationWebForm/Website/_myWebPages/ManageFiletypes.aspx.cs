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

    protected void SearchButton_Click(object sender, EventArgs e)
    {
        if (String.IsNullOrEmpty(SearchFiletype.Text.Trim()))
        {
            SearchFiletype.Text = "";
        }

        LoadData();

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

    protected void filetypes_Gridview_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if(e.CommandName == "Delete")
        {
            e.Handled = true;
            try
            {
                FiletypeController fc = new FiletypeController();
                int rowIndex = (int)Convert.ChangeType(e.CommandArgument, TypeCode.Int32);
                Label filetypeIDControll = (Label) filetypes_Gridview.Rows[rowIndex].FindControl("FiletypeID");

                fc.DeleteFiletype(int.Parse(filetypeIDControll.Text));

                LoadData();
            }
            catch(Exception ex)
            {
                Message.Text = GetInnerException(ex).Message;
            }
        }
    }

    protected void AddFiletypeButton_Click(object sender, EventArgs e)
    {
        try
        {
            FiletypeController fc = new FiletypeController();
            fc.AddFiletype(FiletypeInput.Text);
            LoadData();
        }
        catch(Exception ex)
        {
            Message.Text = GetInnerException(ex).Message;
        }
    }
}