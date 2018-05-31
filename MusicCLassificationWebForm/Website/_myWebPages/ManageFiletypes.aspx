<%@ Page Title="Manage Filetype" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="ManageFiletypes.aspx.cs" Inherits="_myWebPages_ManageFiletypes" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" Runat="Server">  
    <br />
    <br />
    <div class="Jumbotron">
         <div class="row">
            <div class="col-md-4">
                 <h1 style="border-bottom:solid">Manage Filetypes</h1>
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
            <asp:Label ID="SearchFiletypeLabel" runat="server" Text="partial filetype"></asp:Label>
        </div>
    </div>
    <div class="row">
        <div class="col-md-2">
             <asp:TextBox ID="SearchFiletype" runat="server"></asp:TextBox>
        </div>
        <div class="col-md-10">
            <asp:Button ID="SearchButton" runat="server" Text="search" OnClick="SearchButton_Click" /> 
            <asp:Button ID="ClearButton" runat="server" Text="Clear"  CausesValidation="false" OnClick="ClearButton_Click"/>
        </div>
    </div>
    <div class="row">
        <br />
        <br />
    </div>
    <div class="row">
        <div class="col-md-3">
            <asp:GridView ID="filetypes_Gridview" runat="server" AutoGenerateColumns="false"
                BackColor="White" BorderColor="#DEDFDE" BorderStyle="None" BorderWidth="1px" CellPadding="4" ForeColor="Black" GridLines="Vertical" DataSourceID="Filetype_ODS"
                OnRowCommand="filetypes_Gridview_RowCommand">
                <AlternatingRowStyle BackColor="White"></AlternatingRowStyle>
                <Columns>
                    <asp:TemplateField HeaderText="FiletypeID">
                        <ItemTemplate>
                            <asp:Label ID="FiletypeID" runat="server" Text='<%# Eval("FiletypeID") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Filetype">
                        <ItemTemplate>
                            <asp:Label ID="Filetype" runat="server" Text='<%# Eval("Filetype") %>'></asp:Label>
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
                <EmptyDataTemplate>There are no filetypes(s) that match the partial filetype</EmptyDataTemplate>

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
            <asp:Label ID="FiletypeInputLabel" runat="server" Text="new filetype"></asp:Label>
            <br />
            <asp:TextBox ID="FiletypeInput" runat="server"></asp:TextBox>
            <asp:Button ID="AddFiletypeButton" runat="server" Text="Create" OnClick="AddFiletypeButton_Click" />
        </div>
    </div>
    

    <asp:ObjectDataSource ID="Filetype_ODS" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="fetchFiletypesbyPartial" TypeName="MusicDatabase.System.BLL.FiletypeController">
        <SelectParameters>
            <asp:ControlParameter ControlID="SearchFiletype" PropertyName="Text" DefaultValue="__Nothing__" Name="partialFiletype" Type="String"></asp:ControlParameter>
        </SelectParameters>
    </asp:ObjectDataSource>


    <br />
</asp:Content>
