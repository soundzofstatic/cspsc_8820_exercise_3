using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
// make sure to include these using directives
using System.Collections;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.ComponentModel;

[DataObject(true)]
public static class ProductDB
{

    [DataObjectMethod(DataObjectMethodType.Select)]
    public static List<Product> GetProducts()
    {
        List<Product> productList = new List<Product>();
        string sql = "SELECT ProductID, Name, OnHand "
            + "FROM Products ORDER BY Name";
        using (SqlConnection con = new SqlConnection(GetConnectionString()))
        {
            using (SqlCommand cmd = new SqlCommand(sql, con))
            {
                con.Open();
                SqlDataReader dataReader = cmd.ExecuteReader();
                Product product;
                while (dataReader.Read())
                {
                    product = new Product();
                    product.ProductID = dataReader["ProductID"].ToString();
                    product.Name = dataReader["Name"].ToString();
                    product.OnHand = dataReader["OnHand"].ToString();
                    productList.Add(product);
                }
                dataReader.Close();
            }
        }
        return productList;
    }

    [DataObjectMethod(DataObjectMethodType.Update)]
    public static int UpdateProduct(Product original_Product,
        Product product)
    {
        int updateCount = 0;
        string sql = "UPDATE Products "
            + "SET Name = @Name, "
            + "OnHand = @OnHand "
            + "WHERE ProductID = @original_ProductID "
            + "AND Name = @original_Name ";
        using (SqlConnection con = new SqlConnection(GetConnectionString()))
        {
            using (SqlCommand cmd = new SqlCommand(sql, con))
            {
                cmd.Parameters.AddWithValue("Name", product.Name);
                cmd.Parameters.AddWithValue("OnHand", product.OnHand);
                cmd.Parameters.AddWithValue("original_ProductID", original_Product.ProductID);
                cmd.Parameters.AddWithValue("original_Name", original_Product.Name);
                con.Open();
                updateCount = cmd.ExecuteNonQuery();
            }
        }
        return updateCount;
    }
    private static string GetConnectionString()
    {
        return ConfigurationManager.ConnectionStrings
            ["HalloweenConnection"].ConnectionString;
    }
}
