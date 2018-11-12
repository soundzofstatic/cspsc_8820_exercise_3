<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="XEx17ProductReceipt.Default" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Ch17: Product Receipt</title>
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <link href="Content/bootstrap.min.css" rel="stylesheet" />
    <link href="Content/site.css" rel="stylesheet" />
    <script src="Scripts/jquery-1.9.1.min.js"></script>
    <script src="Scripts/bootstrap.min.js"></script>
    <style>
        .bg-halloween.no-hover {
             background-color: #8c8c8c !important;
        }
    </style>
</head>
<body>
<div class="container">
    <header class="jumbotron"><%-- image set in site.css --%></header>
    <main>
        <form id="form1" runat="server" class="form-horizontal">

            <div class="row">
                <div class="col-xs-12">
                    <asp:GridView ID="grdProducts" runat="server"
                        AllowPaging="True"
                        AutoGenerateColumns="False" DataKeyNames="ProductID"
                        DataSourceID="ObjectDataSource1"
                        OnPreRender="grdProducts_PreRender"
                        OnRowUpdated="grdProducts_RowUpdated" 
                        CssClass="table table-bordered table-condensed table-hover"
                        OnSelectedIndexChanged="grdProducts_SelectedIndexChanged">
                        <Columns>
                            <asp:BoundField DataField="ProductID" HeaderText="ID"
                                ReadOnly="True">
                                <ItemStyle CssClass="col-xs-1" />
                            </asp:BoundField>
                            <asp:BoundField DataField="Name" HeaderText="Name"
                                SortExpression="Name">
                                <ItemStyle CssClass="col-xs-7" />
                            </asp:BoundField>
                            <asp:BoundField DataField="OnHand" HeaderText="On Hand"
                                SortExpression="OnHand">
                                <ItemStyle CssClass="col-xs-3" />
                            </asp:BoundField>
                            <asp:CommandField ButtonType="Link" CausesValidation="false"
                                ShowEditButton="true">
                                <ItemStyle CssClass="col-xs-1 text-danger" />
                            </asp:CommandField>
                        </Columns>
                        <HeaderStyle CssClass="bg-halloween" />
                        <AlternatingRowStyle CssClass="altRow" />
                        <EditRowStyle CssClass="warning" />
                        <PagerStyle CssClass="no-hover bg-halloween" HorizontalAlign="Center" />
                    </asp:GridView>
                    <asp:ObjectDataSource runat="server" ID="ObjectDataSource1" 
                        DataObjectTypeName="Product"
                        OldValuesParameterFormatString="original_{0}" 
                        SelectMethod="GetProducts"
                        TypeName="ProductDB" 
                        UpdateMethod="UpdateProduct" 
                        ConflictDetection="CompareAllValues"
                        OnUpdated="ObjectDataSource1_GetAffectedRows">
                        <UpdateParameters>
                            <asp:Parameter Name="original_Product" Type="Object"></asp:Parameter>
                            <asp:Parameter Name="product" Type="Object"></asp:Parameter>
                        </UpdateParameters>
                    </asp:ObjectDataSource>   
                </div>  
            </div>
            <div class="row">
                <div class="col-xs-12">
                    <p><asp:Label ID="lblError" runat="server" 
                        CssClass="text-danger" EnableViewState="false"></asp:Label></p>
                    <asp:ValidationSummary ID="ValidationSummary1" runat="server" 
                        HeaderText="Please correct the following errors:" CssClass="text-danger" />
                </div>
            </div>
        </form>
    </main>
</div>
</body>
</html>