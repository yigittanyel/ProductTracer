namespace Login.WebApi.Models;

public sealed class Products
{
    public int id { get; set; }
    public string name { get; set; }
    public double price { get; set; }

    public Products(int id, string name, double price)
    {
        this.id = id;
        this.name = name;
        this.price = price;
    }

    public Products(string name, double price)
    {
        this.name = name;
        this.price = price;
    }

    public Products()
    {
    }

}
