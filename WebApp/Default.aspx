<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="WebApp.Default" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxtoolkit" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>避免 TextBox 文字設定唯讀 (ReadOnly) 後內容會在 PostBack 事件後清空的範例</title>
    <style>
        .container {
            width: 950px;
            margin: 0 auto;
        }
        #ProductGridView {
            margin:10px 0;
        }

        .product-brand {
            width: 150px;
        }
        .product-name {
            width: 150px;
        }
        .product-onstockdate {
            width: 80px;
        }

        #JsonTextBox {
            width: 950px;
            height: 250px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="container">
            <asp:ScriptManager runat="server" ID="ScriptManager">
                <Scripts>
                    <asp:ScriptReference Path="~/js/jquery-1.8.3.min.js" />
                </Scripts>
            </asp:ScriptManager>

            <asp:UpdatePanel runat="server" ID="UpdatePanel1">
                <ContentTemplate>
                    <div>
                        <asp:Button runat="server" ID="AddButton" Text="新增商品" OnClick="AddButton_Click" />
                        <asp:Button runat="server" ID="SaveButton" Text="儲存商品" OnClick="SaveButton_Click" />
                    </div>

                    <asp:GridView runat="server" ID="ProductGridView" AutoGenerateColumns="false">
                        <Columns>
                            <asp:TemplateField HeaderText="品牌">
                                <ItemTemplate>
                                    <asp:TextBox runat="server" ID="BrandTextBox" CssClass="product-brand" />
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="名稱">
                                <ItemTemplate>
                                    <asp:TextBox runat="server" ID="NameTextBox" CssClass="product-name"/>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="上架日期">
                                <ItemTemplate>
                                    <%--
                                        設定 ReadOnly="ture" 可以防止使用者用輸入的方式填寫日期
                                            當有 PostBack 的事件時，此項目的內容就會被清空
                                        <asp:TextBox runat="server" ID="OnStockDateTextBox" ReadOnly="true" CssClass="product-onstockdate" />
                                    --%>

                                    <%-- 先不設定 ReadOnly 屬性，於下方使用 Javascript 將屬性加入到指定控制項 --%>
                                    <asp:TextBox runat="server" ID="OnStockDateTextBox" CssClass="product-onstockdate" />
                                    <ajaxtoolkit:CalendarExtender runat="server" 
                                                                Format="yyyy/MM/dd"
                                                                TargetControlID="OnStockDateTextBox" />
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>

                    <div>
                        <asp:TextBox runat="server" ID="JsonTextBox" TextMode="MultiLine">
                        </asp:TextBox>
                    </div>
                    
                </ContentTemplate>
            </asp:UpdatePanel>
        </div>
    </form>

    <%-- 使用 Javascript 將屬性 readonly="readonly" 加入到指定控制項 --%>
    <script>
        /* 
            asp.net 保留的事件呼叫方法
            https://dotblogs.com.tw/kevintan1983/2014/02/06/142808
        */
        function pageLoad(sender, args) {
            /* 透過 javascript 設定 readonly 屬性在 postback 的時候就可以保留 textbox 內容 */
            $(".product-onstockdate").each(function () {
                $(this).attr("readonly", "readonly");
            })
        }
    </script>
</body>
</html>
