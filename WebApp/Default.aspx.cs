using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using WebApp.Models;

namespace WebApp
{
    public partial class Default : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if(IsPostBack == false)
            {
                var _products = new List<Product>();
                _products.Add(new Product() {
                                    Brand ="Microsoft"
                                    , Name="Surface Pro"
                                    , OnStockDate = "2017/11/11"
                                });

                this.SetProductToGridView(_products);
            }
        }

        protected void AddButton_Click(object sender, EventArgs e)
        {
            var _products = this.GetProductFromGridView();

            _products.Add(new Product());

            this.SetProductToGridView(_products);
        }

        protected void SaveButton_Click(object sender, EventArgs e)
        {
            var _products = this.GetProductFromGridView();

            this.JsonTextBox.Text
                = JsonConvert.SerializeObject(_products, Formatting.Indented);
        }

        private List<Product> GetProductFromGridView()
        {
            List<Product> _products;

            _products = new List<Product>();

            TextBox _BrandTextBox;
            TextBox _NameTextBox;
            TextBox _OnStockDateTextBox;

            foreach (GridViewRow _gridViewRow in this.ProductGridView.Rows)
            {
                if(_gridViewRow.RowType == DataControlRowType.DataRow)
                {
                    _BrandTextBox = _gridViewRow.FindControl("BrandTextBox") as TextBox;
                    _NameTextBox = _gridViewRow.FindControl("NameTextBox") as TextBox;
                    _OnStockDateTextBox = _gridViewRow.FindControl("OnStockDateTextBox") as TextBox;

                    _products.Add(new Product()
                    {
                        Brand = _BrandTextBox.Text,
                        Name = _NameTextBox.Text,
                        OnStockDate = _OnStockDateTextBox.Text
                    });
                }
            }

            return _products;
        }

        private void SetProductToGridView(IEnumerable<Product> products)
        {
            int _index;
            List<Product> _products;

            _products = new List<Product>();

            TextBox _BrandTextBox;
            TextBox _NameTextBox;
            TextBox _OnStockDateTextBox;

            _index = 0;

            this.ProductGridView.DataSource = products;
            this.ProductGridView.DataBind();

            foreach (Product _product in products)
            {
                var _gridViewRow = this.ProductGridView.Rows[_index];

                _BrandTextBox = _gridViewRow.FindControl("BrandTextBox") as TextBox;
                _NameTextBox = _gridViewRow.FindControl("NameTextBox") as TextBox;
                _OnStockDateTextBox = _gridViewRow.FindControl("OnStockDateTextBox") as TextBox;

                _BrandTextBox.Text = _product.Brand;
                _NameTextBox.Text = _product.Name;
                _OnStockDateTextBox.Text = _product.OnStockDate;

                _index = _index + 1;
            }
        }

        private List<Product> Products
        {
            get
            {
                if (ViewState["Products"] == null)
                    ViewState["Products"] = new List<Product>();

                return ViewState["Products"] as List<Product>;
            }
            set
            {
                ViewState["Products"] = value;
            }
        }
    }
}