using BarberSchedule.Services.OrdersAPI.Dto;
using BarberSchedule.Services.OrdersAPI.Services;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace BarberSchedule.Services.OrdersAPI.Controllers
{
    [Authorize]
    [Route("api/[controller]")]
    [ApiController]
    public class OrdersController : ControllerBase
    {
        public IOrdersService _ordersService { get; set; }
        public IBarberShopService _barberShopService { get; set; }
        public OrdersController(
            IOrdersService ordersService,
            IBarberShopService barberShopService)
        {
            _ordersService = ordersService;
            _barberShopService = barberShopService;
        }

        [HttpPost]
        public async Task<IActionResult> CreateOrder([FromBody] CreateOrderRequestDto request)
        {
            var result = await _ordersService.CreateOrder(request);
            if (!result)
            {
                return BadRequest();
            }
            return Created();
        }

        [HttpGet]
        public async Task<IActionResult> GetOrdersByUserId([FromQuery] GetOrderByUserIdQueryParameter queryParameter)
        {
            string token = Request.Headers["Authorization"].ToString().Split(' ')[1];
            var result = await _ordersService.GetOrderByUserId(queryParameter.UserId);
            if(result == null)
            {
                return NotFound();
            }

            foreach (var item in result)
            {
                var result2 = await _barberShopService.GetBarberShopById(item.BarberShopId, token);
                item.BarberShop = result2;
            }

            return Ok(result);
        }
    }
}
