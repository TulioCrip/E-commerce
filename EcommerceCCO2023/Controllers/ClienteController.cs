using EcommerceCCO2023.Models.Data;
using EcommerceCCO2023.Models;
using Microsoft.AspNetCore.Mvc;

namespace EcommerceCCO2023.Controllers
{
    public class ClienteController : Controller
    {
        public IActionResult IndexCliente()
        {
            ClienteData data = new ClienteData();
            return View(data.Read());
        }

        public IActionResult Create()
        {
            return View();
        }

        [HttpPost]
        public IActionResult Create(Cliente clie)
        {
            if (clie.Nome != null)
            {
                ClienteData data = new ClienteData();
                data.Create(clie);
            }

            return RedirectToAction("IndexCliente");
        }

        [HttpGet]
        public IActionResult Update(int id)
        {
            ClienteData data = new ClienteData();
            return View(data.Read(id));
        }

        [HttpPost]
        public IActionResult Update(int id, Cliente cliente)
        {
            cliente.IdCliente = id;

            if (cliente.Nome == null)
                return View(cliente);

            ClienteData data = new ClienteData();
            data.Update(cliente);

            return RedirectToAction("Index", "Home");
        }

        public IActionResult Delete(int id)
        {
            ClienteData data = new ClienteData();
            data.Delete(id);

            return RedirectToAction("Index", "Home");
        }
    }
}
