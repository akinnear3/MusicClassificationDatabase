<%@ Page Title="Manage Ratings" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="ManageRatings.aspx.cs" Inherits="_myWebPages_ManageRatings" %>


<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" Runat="Server">  
    <br />
    <br />
    <div class="Jumbotron">
          <div class="row">
            <div class="col-md-3">
                 <h1 style="border-bottom:solid">Manage Ratings</h1>
            </div>
         </div>
    </div>
    <br />

    <asp:Label ID="Message" runat="server" Text=""></asp:Label>
    <asp:ValidationSummary ID="ValidationSummary1" runat="server" />
    <%--add valadators here--%>

    <br />

        <div class="row">
        <div class="col-md-12">
            <asp:Label ID="SearchRatingNameLabel" runat="server" Text="partial Rating name"></asp:Label>
        </div>
    </div>
    <div class="row">
        <div class="col-md-2">
             <asp:TextBox ID="SearchRatingName" runat="server"></asp:TextBox>
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
            <asp:GridView ID="Ratings_Gridview" runat="server" AutoGenerateColumns="false"
                BackColor="White" BorderColor="#DEDFDE" BorderStyle="None" BorderWidth="1px" CellPadding="4" ForeColor="Black" GridLines="Vertical" DataSourceID="Ratings_ODS"
                OnRowCommand="Ratings_Gridview_RowCommand">
                <AlternatingRowStyle BackColor="White"></AlternatingRowStyle>
                <Columns>
                    <asp:TemplateField HeaderText="RatingID">
                        <ItemTemplate>
                            <asp:Label ID="RatingID" runat="server" Text='<%# Eval("RatingID") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Rating">
                        <ItemTemplate>
                            <asp:Label ID="Rating" runat="server" Text='<%# Eval("Rating") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="">
                        <ItemTemplate>
                            <asp:Button ID="DeleteButton" runat="server" Text="Delete" 
                                CommandName="Delete" CommandArgument="<%# ((GridViewRow) Container).RowIndex %>"/>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>

                <EmptyDataRowStyle HorizontalAlign="Center"></EmptyDataRowStyle>
                <EmptyDataTemplate>There are no Rating(s) that match the partial Rating</EmptyDataTemplate>

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
            <asp:Label ID="RatingNameLabel" runat="server" Text="new Rating name"></asp:Label>
            <br />
            <asp:TextBox ID="RatingName" runat="server"></asp:TextBox>
            <asp:Button ID="AddRatingButton" runat="server" Text="Create" OnClick="AddRatingButton_Click" />
        </div>
    </div>
    

    <asp:ObjectDataSource ID="Ratings_ODS" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="searchRatings" TypeName="MusicDatabase.System.BLL.RatingController">
        <SelectParameters>
            <asp:ControlParameter ControlID="SearchRatingName" PropertyName="Text" Name="partialRating" Type="String" DefaultValue="__No_th_ing_"></asp:ControlParameter>
        </SelectParameters>
    </asp:ObjectDataSource>


    <br />
</asp:Content>

