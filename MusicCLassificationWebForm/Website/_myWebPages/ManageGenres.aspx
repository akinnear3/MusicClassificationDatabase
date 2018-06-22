<%@ Title="Manage Genres" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="ManageGenres.aspx.cs" Inherits="_myWebPages_ManageGenres" %>


<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" Runat="Server">  
    <br />
    <br />
    <div class="Jumbotron">
        <div class="row">
            <div class="col-md-3">
                 <h1 style="border-bottom:solid">Manage Genres</h1>
            </div>
         </div>
           
    </div>
    <br />

    <asp:Label ID="Message" runat="server" Text=""></asp:Label>
    <asp:ValidationSummary ID="ValidationSummary1" runat="server" ForeColor="Red" BackColor="Yellow"/>
    <%--add valadators here--%>
    <asp:CompareValidator ID="CompareValidator1" runat="server" ErrorMessage="Genre name is invalid, genre name is required."
         ControlToValidate="GenreName" ValueToCompare="!!!Invalid_!_Name!!!" Type="String" Operator="NotEqual" Display="None"></asp:CompareValidator>

    <br />

    <div class="row">
        <div class="col-md-12">
            <asp:Label ID="SearchGenreNameLabel" runat="server" Text="partial Genre name"></asp:Label>
        </div>
    </div>
    <div class="row">
        <div class="col-md-2">
             <asp:TextBox ID="SearchGenreName" runat="server"></asp:TextBox>
        </div>
        <div class="col-md-10">
            <asp:Button ID="SearchButton" runat="server" Text="search" OnClick="SearchButton_Click" /> 
            <asp:Button ID="ClearButton" runat="server" Text="Clear"  CausesValidation="false" OnClick="ClearButton_Click" />
        </div>
    </div>
    <div class="row">
        <br />
        <br />
    </div>
    <div class="row">
        <div class="col-md-3">
            <asp:GridView ID="Genres_Gridview" runat="server" AutoGenerateColumns="false"
                BackColor="White" BorderColor="#DEDFDE" BorderStyle="None" BorderWidth="1px" CellPadding="4" ForeColor="Black" GridLines="Vertical" DataSourceID="Genres_ODS"
                OnRowCommand="Genres_Gridview_RowCommand">
                <AlternatingRowStyle BackColor="White"></AlternatingRowStyle>
                <Columns>
                    <asp:TemplateField HeaderText="GenreID">
                        <ItemTemplate>
                            <asp:Label ID="GenreID" runat="server" Text='<%# Eval("GenreID") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Genre">
                        <ItemTemplate>
                            <asp:Label ID="Genre" runat="server" Text='<%# Eval("genre") %>'></asp:Label>
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
                <EmptyDataTemplate>There are no Genre(s) that match the partial genre</EmptyDataTemplate>

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
        <div class="col-md-9">
            <asp:Label ID="GenreNameLabel" runat="server" Text="new Genre name"></asp:Label>
            <asp:Label ID="UpdatingGenreID" runat="server" Text="" Visible="false"></asp:Label>
            <br />
            <asp:TextBox ID="GenreName" runat="server"></asp:TextBox>
             <asp:Button ID="UpdateGenreButton" runat="server" Text="Update" Visible="false" 
                 OnClick="UpdateGenreButton_Click" CausesValidation="true"/>
            <asp:Button ID="AddGenreButton" runat="server" Text="Create" 
                OnClick="AddGenreButton_Click" />
            <asp:Button ID="CancelUpdateButton" runat="server" Text="Cancel Update" Visible="false"
                OnClick="CancelUpdateButton_Click"  CausesValidation="false"/>
        </div>
    </div>
    

    <asp:ObjectDataSource ID="Genres_ODS" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="searchGenres" TypeName="MusicDatabase.System.BLL.GenreController">
        <SelectParameters>
            <asp:ControlParameter ControlID="SearchGenreName" PropertyName="Text" Name="partialGenre" Type="String" DefaultValue="__No_th_ing_"></asp:ControlParameter>
        </SelectParameters>
    </asp:ObjectDataSource>


    <br />
</asp:Content>

