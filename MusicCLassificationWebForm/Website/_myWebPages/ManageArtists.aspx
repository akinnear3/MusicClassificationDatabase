<%@ Page Title="Manage Artists" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="ManageArtists.aspx.cs" Inherits="_myWebPages_ManageArtists" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" Runat="Server">  
    
    <br />
    <br />
    <div class="Jumobotron">
        <div class="row">
            <div class="col-md-3">
                 <h1 style="border-bottom:solid">Manage Artists </h1>
            </div>
         </div>
    </div>
    <br />

    <asp:Label ID="Message" runat="server" Text=""></asp:Label>
    <asp:ValidationSummary ID="ValidationSummary1" runat="server" ForeColor="Red" BackColor="Yellow"/>
    <br />
  
    <%--add valadators here--%>
    <asp:CompareValidator ID="CompareValidator1" runat="server" ErrorMessage="Artist name is invalid, a name is required to add artists"
         ControlToValidate="ArtistName" ValueToCompare="!!!Invalid_!_Name!!!" Type="String" Operator="NotEqual" Display="None"></asp:CompareValidator>

    <div class="row">
        <div class="col-md-12">
            <asp:Label ID="SearchArtistNameLabel" runat="server" Text="partial Artist name"></asp:Label>
        </div>
    </div>
    <div class="row">
        <div class="col-md-2">
             <asp:TextBox ID="SearchArtistName" runat="server"></asp:TextBox>
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
            <asp:GridView ID="Artists_Gridview" runat="server" AutoGenerateColumns="false"
                BackColor="White" BorderColor="#DEDFDE" BorderStyle="None" BorderWidth="1px" CellPadding="4" ForeColor="Black" GridLines="Vertical" DataSourceID="Artists_ODS"
                OnRowCommand="Artists_Gridview_RowCommand">
                <AlternatingRowStyle BackColor="White"></AlternatingRowStyle>
                <Columns>
                    <asp:TemplateField HeaderText="ArtistID">
                        <ItemTemplate>
                            <asp:Label ID="ArtistID" runat="server" Text='<%# Eval("ArtistID") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Artist">
                        <ItemTemplate>
                            <asp:Label ID="Artist" runat="server" Text='<%# Eval("name") %>'></asp:Label>
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
                <EmptyDataTemplate>There are no artist(s) that match the partial name</EmptyDataTemplate>

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
            <asp:Label ID="ArtistNameLabel" runat="server" Text="new Artist name"></asp:Label>
            <br />
            <asp:TextBox ID="ArtistName" runat="server"></asp:TextBox>
            <asp:Button ID="UpdateArtistButton" runat="server" Text="Update" Visible="false" OnClick="UpdateArtistButton_Click" CausesValidation="true"/>
            <asp:Label ID="UpdatingArtistID" runat="server" Text="" Visible="false"></asp:Label>
            <asp:Button ID="AddArtistButton" runat="server" Text="Create" OnClick="AddArtistButton_Click"  CausesValidation="true"/>
            <asp:Button ID="CancelUpdateButton" runat="server" Text="Cancel Update" Visible="false" OnClick="CancelUpdateButton_Click"  CausesValidation="false"/>
        </div>
    </div>
    

    <asp:ObjectDataSource ID="Artists_ODS" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="searchArtists" TypeName="MusicDatabase.System.BLL.ArtistController">
        <SelectParameters>
            <asp:ControlParameter ControlID="SearchArtistName" PropertyName="Text" DefaultValue="__Nothing__" Name="partialName" Type="String"></asp:ControlParameter>
        </SelectParameters>
    </asp:ObjectDataSource>


    <br />

</asp:Content>

