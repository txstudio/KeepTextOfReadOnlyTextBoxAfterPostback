using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WebApp.Models
{
    [Serializable]
    public sealed class Product
    {
        public string Brand { get; set; }
        public string Name { get; set; }
        public string OnStockDate { get; set; }
    }
}