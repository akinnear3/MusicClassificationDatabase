<%@ Page Title="Search Database" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="SearchDatabase.aspx.cs" Inherits="_myWebPages_SearchDatabase" %>


<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" Runat="Server">  
    <br />
    <br />

    <style>
    html
    {

    }
    .tabs
    {
        position:relative;
        top:1px;
        left:10px;

     }
    .tabs
    {
        position:relative;
        top:1px;
        left:10px;
    }
    .selectedTab
    {
        background-color:white;
        border-bottom:solid 1px white;

    }
    .tabContents
    {
        border:solid 1px black;
        padding:10px;
        background-color:white;
    }
</style>

    <div class="Jumbotron">
        <div class="row">
            <div class="col-md-3">
                 <h1 style="border-bottom:solid">Music Database</h1>
            </div>
         </div>
    </div>
    <div>
            <asp:Label ID="Message" runat="server" Text=""></asp:Label>
            <asp:ValidationSummary ID="ValidationSummary1" runat="server" />
            <%--add valadators here--%>

    </div>
    <div>
        <asp:Menu ID="TabMenu" Orientation="Horizontal" StaticMenuItemStyle-CssClass="tabs" Font-Size="Large" 
            StaticSelectedStyle-CssClass="selectedTab" StaticMenuItemStyle-HorizontalPadding="50px" StaticSelectedStyle-BackColor="White"
            CssClass="tabs" runat="server" OnMenuItemClick="TabMenu_MenuItemClick">
            <Items>
                <asp:MenuItem Text="Search" Value="0" Selected="true"></asp:MenuItem>
                 <asp:MenuItem Text="Add New" Value="1" Selected="false"></asp:MenuItem>
            </Items>
        </asp:Menu>
    </div>
    
    <div class="tabContents">
        <asp:MultiView ID="SearchDatabase_Multiview" ActiveViewIndex="0" runat="server">
            <asp:View ID="SearchView" runat="server"> 

                <!--this is for describing what to search for-->
                <div class="row">
                    <!--the labels-->
                    <div class="col-md-2">
                        <asp:Label ID="SearchSongNameLabel" runat="server" Text="Partial Name"></asp:Label>
                    </div>
                     <div class="col-md-2">
                        <asp:Label ID="SearchFiletypeLabel" runat="server" Text="Filetype"></asp:Label>
                    </div>
                    
                     <div class="col-md-2">
                         <asp:Label ID="SearchGenreLabel" runat="server" Text="Genre"></asp:Label>
                    </div> 
                    
                    <div class="col-md-2">
                         <asp:Label ID="SearchRatingLabel" runat="server" Text="Rating"></asp:Label>
                    </div>
                    
                     <div class="col-md-2">
                         <asp:Label ID="SearchArtistLabel" runat="server" Text="Artist"></asp:Label>
                    </div>
                    <div class="col-md-2">
                        <asp:Button ID="SearchDatabaseButton" runat="server" Text="Search" OnClick="SearchDatabaseButton_Click" />
                    </div>
                </div>
                
                <div class="row">
                    <!--the input-->
                    <div class="col-md-2">
                         <asp:TextBox ID="SearchSongName" runat="server"></asp:TextBox>  
                    </div>
                    <div class="col-md-2">
                        <asp:DropDownList ID="SearchFiletypeDDL" runat="server" 
                            DataSourceID="AllFiletypes_ODS" DataTextField="Filetype" DataValueField="FiletypeID"
                            AppendDataBoundItems="true">
                             <asp:ListItem Value="0">All Filetypes</asp:ListItem>
                         </asp:DropDownList>
                    </div>
                    <div class="col-md-2">
                        <asp:DropDownList ID="SearchGenreDDL" runat="server" 
                            DataSourceID="AllGenres_ODS" DataTextField="Genre" DataValueField="GenreID"
                            AppendDataBoundItems="true">
                            <asp:ListItem Value="0">All Genres</asp:ListItem>
                        </asp:DropDownList> 
                    </div>
                    <div class="col-md-2">
                        <asp:DropDownList ID="SearchRatingDDL" runat="server" 
                            DataSourceID="AllRatings_ODS" DataTextField="Rating" DataValueField="RatingID"
                            AppendDataBoundItems="true">
                            <asp:ListItem Value="0">All Ratings</asp:ListItem>
                        </asp:DropDownList>
                    </div>
                    <div class="col-md-2">
                        <asp:DropDownList ID="SearchArtistDDL" runat="server" 
                            DataSourceID="AllArtists_ODS" DataTextField="Name" DataValueField="ArtistID" 
                            AppendDataBoundItems="true">
                            <asp:ListItem Value="0">All Artists</asp:ListItem>
                        </asp:DropDownList> 
                    </div>      
                    <div class="col-md-2">
                        <asp:Button ID="ClearSearParamsButton" runat="server" Text="Clear Restrictions" OnClick="ClearSearParamsButton_Click" />
                    </div>
                </div>
                <br /> 

    <asp:GridView ID="SearchInfo_GridView" runat="server" BackColor="White" BorderColor="#DEDFDE" BorderStyle="None" BorderWidth="1px" CellPadding="4" ForeColor="Black" GridLines="Vertical"
         OnRowCommand="SearchInfo_GridView_RowCommand" Width="100%" AutoGenerateColumns="false">
        <AlternatingRowStyle BackColor="White"></AlternatingRowStyle>
        <Columns>
            <asp:TemplateField HeaderText="SongID" Visible="false">
                <ItemTemplate>
                    <asp:Label ID="SongID" runat="server" Text='<%# Eval("SongID") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="SongName">
                <ItemTemplate>
                    <asp:Label ID="SongName" runat="server" Text='<%# Eval("SongName") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="FiletypeID" Visible="false">
                <ItemTemplate>
                    <asp:Label ID="FiletypeID" runat="server" Text='<%# Eval("FiletypeID") %>' Visible="false"></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
                        <asp:TemplateField HeaderText="Filetype" Visible="true">
                <ItemTemplate>
                    <asp:Label ID="Filetype" runat="server" Text='<%# Eval("Filetype") %>' Visible="true"></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Genres">
                <ItemTemplate>
                    <asp:Label ID="Genres" runat="server" Text='<%# Eval("Genres") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Ratings">
                <ItemTemplate>
                    <asp:Label ID="Ratings" runat="server" Text='<%# Eval("Ratings") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Artists">
                <ItemTemplate>
                    <asp:Label ID="Artists" runat="server" Text='<%# Eval("Artists") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="">
                <ItemTemplate>
                    <asp:Button ID="DeleteButton" runat="server" Text="Delete" 
                        CommandName="Delete" CommandArgument="<%# ((GridViewRow) Container).RowIndex %>"/>
                </ItemTemplate>
            </asp:TemplateField>
             <asp:TemplateField HeaderText="">
                <ItemTemplate>
                      <asp:Button ID="EditButton" runat="server" Text="Edit" 
                        CommandName="Edit" CommandArgument="<%# ((GridViewRow) Container).RowIndex %>"/>
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>

        <EmptyDataRowStyle HorizontalAlign="Center"></EmptyDataRowStyle>
        <EmptyDataTemplate>No Songs Found</EmptyDataTemplate>

        <FooterStyle BackColor="#CCCC99"></FooterStyle>

        <HeaderStyle BackColor="#6B696B" Font-Bold="True" ForeColor="White"></HeaderStyle>

        <PagerStyle HorizontalAlign="Right" BackColor="#F7F7DE" ForeColor="Black"></PagerStyle>

        <RowStyle BackColor="#F7F7DE"></RowStyle>

        <SelectedRowStyle BackColor="#CE5D5A" Font-Bold="True" ForeColor="White"></SelectedRowStyle>

        <SortedAscendingCellStyle BackColor="#FBFBF2"></SortedAscendingCellStyle>

        <SortedAscendingHeaderStyle BackColor="#848384"></SortedAscendingHeaderStyle>

        <SortedDescendingCellStyle BackColor="#EAEAD3"></SortedDescendingCellStyle>

        <SortedDescendingHeaderStyle BackColor="#575357"></SortedDescendingHeaderStyle>
    </asp:GridView>

            </asp:View>
            <asp:View ID="EditView" runat="server">
                <br />
                <div class="row">
                    <div class="col-md-2">
                        &nbsp
                        <asp:Label ID="EditingLabels" runat="server" Text="Song Name"></asp:Label>
                    </div>
                    <div class="col-md-2">
                        <asp:Label ID="Label1" runat="server" Text="Filetype"></asp:Label>
                    </div>
                </div>
                <div class="row">
                    &nbsp&nbsp&nbsp&nbsp
                    <asp:Label ID="EditingSongID" runat="server" Text="" Visible ="false"></asp:Label>
                    <asp:TextBox ID="EditingSongName" runat="server" Text=""></asp:TextBox>
                    &nbsp&nbsp&nbsp&nbsp
                    <asp:DropDownList ID="EditingFiletypeDDL" runat="server" AppendDataBoundItems="false">
                    </asp:DropDownList>

                    &nbsp&nbsp&nbsp&nbsp
                    <asp:Button ID="Create_NewSong" runat="server" Text="Create Song" OnClick="Create_NewSong_Click" />
                    <asp:Button ID="Update_SongNameAndFiletype" runat="server" Text="Update Name and Filetype" OnClick="Update_SongNameAndFiletype_Click" />
                </div>
               

                <br />
               
                <div class="row">
                    <div class="col-md-6">
                        <asp:GridView ID="EditingGenres_GridView" runat="server" BackColor="White" BorderColor="#DEDFDE" BorderStyle="None" BorderWidth="1px" CellPadding="4" ForeColor="Black" GridLines="Vertical"
                        OnRowCommand="EditingGenres_GridView_RowCommand" Width="531px" AutoGenerateColumns="false">
                        <AlternatingRowStyle BackColor="White"></AlternatingRowStyle>
                            <Columns>
                                <asp:TemplateField HeaderText="GenreID">
                                    <ItemTemplate>
                                        <asp:Label ID="EditingGenreID" runat="server" Text='<%# Eval("GenreID") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Genre">
                                    <ItemTemplate>
                                        <asp:Label ID="EditingGenre" runat="server" Text='<%# Eval("Genre") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="SongID" Visible="false">
                                    <ItemTemplate>
                                        <asp:Label ID="EditingSongID" runat="server" Text='<%# Eval("SongID") %>' Visible="false"></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="">
                                    <ItemTemplate>
                                        <asp:Button ID="EditingDeleteButton" runat="server" Text="Delete" 
                                            CommandName="Delete" CommandArgument="<%# ((GridViewRow) Container).RowIndex %>"/>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>

                            <EmptyDataRowStyle HorizontalAlign="Center"></EmptyDataRowStyle>
                            <EmptyDataTemplate>The song has not been taged with Genre(s)</EmptyDataTemplate>

                            <FooterStyle BackColor="#CCCC99"></FooterStyle>

                            <HeaderStyle BackColor="#6B696B" Font-Bold="True" ForeColor="White"></HeaderStyle>

                            <PagerStyle HorizontalAlign="Right" BackColor="#F7F7DE" ForeColor="Black"></PagerStyle>

                            <RowStyle BackColor="#F7F7DE"></RowStyle>

                            <SelectedRowStyle BackColor="#CE5D5A" Font-Bold="True" ForeColor="White"></SelectedRowStyle>

                            <SortedAscendingCellStyle BackColor="#FBFBF2"></SortedAscendingCellStyle>

                            <SortedAscendingHeaderStyle BackColor="#848384"></SortedAscendingHeaderStyle>

                            <SortedDescendingCellStyle BackColor="#EAEAD3"></SortedDescendingCellStyle>

                            <SortedDescendingHeaderStyle BackColor="#575357"></SortedDescendingHeaderStyle>
                        </asp:GridView>
                    </div>
                    <div class="col-md-6">
                        <asp:DropDownList ID="GenreToAddDDL" runat="server" 
                            DataSourceID="AllGenres_ODS" DataTextField="genre" DataValueField="GenreID" 
                            AppendDataBoundItems="true">
                            <asp:ListItem Value="0">Select...</asp:ListItem>
                        </asp:DropDownList>
                        <asp:Button ID="AddGenreButton" runat="server" Text="Add Genre" OnClick="AddGenreButton_Click" />

                    </div>
                </div>

                
                <br />
                  <div class="row">
                    <div class="col-md-6">
                        <asp:GridView ID="EditingRatings_GridView" runat="server" BackColor="White" BorderColor="#DEDFDE" BorderStyle="None" BorderWidth="1px" CellPadding="4" ForeColor="Black" GridLines="Vertical"
                             OnRowCommand="EditingRatings_GridView_RowCommand" Width="531px" AutoGenerateColumns="false">
                            <AlternatingRowStyle BackColor="White"></AlternatingRowStyle>
                            <Columns>
                                <asp:TemplateField HeaderText="RatingID">
                                    <ItemTemplate>
                                        <asp:Label ID="EditingRatingID" runat="server" Text='<%# Eval("RatingID") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Rating">
                                    <ItemTemplate>
                                        <asp:Label ID="EditingRating" runat="server" Text='<%# Eval("Rating") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="SongID" Visible="false">
                                    <ItemTemplate>
                                        <asp:Label ID="EditingSongID" runat="server" Text='<%# Eval("SongID") %>' Visible="false"></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="">
                                    <ItemTemplate>
                                        <asp:Button ID="EditingDeleteButton" runat="server" Text="Delete" 
                                            CommandName="Delete" CommandArgument="<%# ((GridViewRow) Container).RowIndex %>"/>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>

                            <EmptyDataRowStyle HorizontalAlign="Center"></EmptyDataRowStyle>
                            <EmptyDataTemplate>The song has not been given Rating(s)</EmptyDataTemplate>

                            <FooterStyle BackColor="#CCCC99"></FooterStyle>

                            <HeaderStyle BackColor="#6B696B" Font-Bold="True" ForeColor="White"></HeaderStyle>

                            <PagerStyle HorizontalAlign="Right" BackColor="#F7F7DE" ForeColor="Black"></PagerStyle>

                            <RowStyle BackColor="#F7F7DE"></RowStyle>

                            <SelectedRowStyle BackColor="#CE5D5A" Font-Bold="True" ForeColor="White"></SelectedRowStyle>

                            <SortedAscendingCellStyle BackColor="#FBFBF2"></SortedAscendingCellStyle>

                            <SortedAscendingHeaderStyle BackColor="#848384"></SortedAscendingHeaderStyle>

                            <SortedDescendingCellStyle BackColor="#EAEAD3"></SortedDescendingCellStyle>

                            <SortedDescendingHeaderStyle BackColor="#575357"></SortedDescendingHeaderStyle>
                        </asp:GridView>
                      </div>
                      <div class="col-md-6">
                          <asp:DropDownList ID="RatingToAddDDL" runat="server"
                              DataSourceID="AllRatings_ODS" DataTextField="rating" DataValueField="RatingID"
                              AppendDataBoundItems="true">
                            <asp:ListItem Value="0">Select...</asp:ListItem>
                        </asp:DropDownList>
                        <asp:Button ID="AddRatingButton" runat="server" Text="Add Rating" OnClick="AddRatingButton_Click" />
                      </div>
                  </div>
                <br />
                <div class="row">
                    <div class="col-md-6">
                        <asp:GridView ID="EditingArtists_GridView" runat="server" BackColor="White" BorderColor="#DEDFDE" BorderStyle="None" BorderWidth="1px" CellPadding="4" ForeColor="Black" GridLines="Vertical"
                             OnRowCommand="EditingArtists_GridView_RowCommand" Width="531px" AutoGenerateColumns="false">
                            <AlternatingRowStyle BackColor="White"></AlternatingRowStyle>
                            <Columns>
                                <asp:TemplateField HeaderText="ArtistID">
                                    <ItemTemplate>
                                        <asp:Label ID="EditingArtistID" runat="server" Text='<%# Eval("ArtistID") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Artist">
                                    <ItemTemplate>
                                        <asp:Label ID="EditingArtist" runat="server" Text='<%# Eval("name") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="SongID" Visible="false">
                                    <ItemTemplate>
                                        <asp:Label ID="EditingSongID" runat="server" Text='<%# Eval("SongID") %>' Visible="false"></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="">
                                    <ItemTemplate>
                                        <asp:Button ID="EditingDeleteButton" runat="server" Text="Delete" 
                                            CommandName="Delete" CommandArgument="<%# ((GridViewRow) Container).RowIndex %>"/>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>

                            <EmptyDataRowStyle HorizontalAlign="Center"></EmptyDataRowStyle>
                            <EmptyDataTemplate>the song has not been taged with Artist(s)</EmptyDataTemplate>

                            <FooterStyle BackColor="#CCCC99"></FooterStyle>

                            <HeaderStyle BackColor="#6B696B" Font-Bold="True" ForeColor="White"></HeaderStyle>

                            <PagerStyle HorizontalAlign="Right" BackColor="#F7F7DE" ForeColor="Black"></PagerStyle>

                            <RowStyle BackColor="#F7F7DE"></RowStyle>

                            <SelectedRowStyle BackColor="#CE5D5A" Font-Bold="True" ForeColor="White"></SelectedRowStyle>

                            <SortedAscendingCellStyle BackColor="#FBFBF2"></SortedAscendingCellStyle>

                            <SortedAscendingHeaderStyle BackColor="#848384"></SortedAscendingHeaderStyle>

                            <SortedDescendingCellStyle BackColor="#EAEAD3"></SortedDescendingCellStyle>

                            <SortedDescendingHeaderStyle BackColor="#575357"></SortedDescendingHeaderStyle>
                        </asp:GridView>
                    </div>
                    <div class="col-md-6">
                        <asp:DropDownList ID="ArtistToAddDDL" runat="server"
                            DataSourceID="AllArtists_ODS" DataTextField="name" DataValueField="ArtistID"
                            AppendDataBoundItems="true">
                            <asp:ListItem Value="0">Select...</asp:ListItem>
                        </asp:DropDownList>
                        <asp:Button ID="AddArtistButton" runat="server" Text="Add Artist" OnClick="AddArtistButton_Click" />
                    </div>
                </div>
            </asp:View>
        </asp:MultiView>
    </div>

    <asp:ObjectDataSource ID="AllArtists_ODS" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="fetchAllArtists" TypeName="MusicDatabase.System.BLL.ArtistController"></asp:ObjectDataSource>
    <asp:ObjectDataSource ID="AllGenres_ODS" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetAllGenres" TypeName="MusicDatabase.System.BLL.GenreController"></asp:ObjectDataSource>
    <asp:ObjectDataSource ID="AllFiletypes_ODS" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetFiletypes" TypeName="MusicDatabase.System.BLL.FiletypeController"></asp:ObjectDataSource>
    <asp:ObjectDataSource ID="AllRatings_ODS" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetAllRatings" TypeName="MusicDatabase.System.BLL.RatingController"></asp:ObjectDataSource>
   
    
    <br />
</asp:Content>

