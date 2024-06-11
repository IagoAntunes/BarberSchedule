using BarberSchedule.Services.BarberShop.Service.Interfaces;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace BarberSchedule.Services.BarberShop.Controllers
{
    [Authorize]
    [Route("api/[controller]")]
    [ApiController]
    public class PaymentMethodsController : ControllerBase
    {
        private readonly IPaymentMethodsService _paymentMethodsService;

        public PaymentMethodsController(
            IPaymentMethodsService paymentMethodsService)
        {
            _paymentMethodsService = paymentMethodsService;
        }


        [HttpGet("GetAll")]
        public async Task<IActionResult> GetAllPaymentMethods()
        {
            var result = await _paymentMethodsService.GetAllPaymentMethods();

            return Ok(result);
        }


    }
}
