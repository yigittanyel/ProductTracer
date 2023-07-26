using Login.WebApi.Models;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace Login.WebApi.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class ProductsController : ControllerBase
    {
        public static List<Products> Products = new List<Products>
        {
            new Products { id = 1, name = "Product 1", price = 100 },
            new Products { id = 2, name = "Product 2", price = 200 },
            new Products { id = 3, name = "Product 3", price = 300 },
            new Products { id = 4, name = "Product 4", price = 400 },
            new Products { id = 5, name = "Product 5", price = 500 },
        };

        [HttpGet]
        [Route("getProducts")]
        public IActionResult GetProducts()
        {
            return Ok(Products);
        }

        [HttpGet]
        [Route("getProduct/{id}")]
        public IActionResult GetProduct(int id)
        {
            var product = Products.FirstOrDefault(x => x.id == id);
            if (product == null)
            {
                return NotFound();
            }
            return Ok(product);
        }

        [HttpPost]
        [Route("addProduct")]
        public IActionResult AddProduct(Products product)
        {
            Products.Add(product);
            return Ok(product);
        }

        [HttpPut]
        [Route("updateProduct/{id}")]
        public IActionResult UpdateProduct(int id, Products product)
        {
            var existingProduct = Products.FirstOrDefault(x => x.id == id);
            if (existingProduct != null)
            {
                existingProduct.name = product.name;
                existingProduct.price = product.price;
                return Ok(existingProduct);
            }
            return NotFound();
        }
        
        [HttpDelete]
        [Route("deleteProduct/{id}")]
        public IActionResult DeleteProduct(int id)
        {
            var product = Products.FirstOrDefault(x => x.id == id);
            if (product == null)
            {
                return NotFound();
            }
            Products.Remove(product);
            return Ok(product);
        }

    }
}
