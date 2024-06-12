using BarberSchedule.MessageBus;
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
        public IMessageBus _messageBus { get; set; }
        public IConfiguration _configuration { get; set; }
        public OrdersController(
            IOrdersService ordersService,
            IBarberShopService barberShopService,
            IMessageBus messageBus,
            IConfiguration configuration)
        {
            _ordersService = ordersService;
            _barberShopService = barberShopService;
            _messageBus = messageBus;
            _configuration = configuration;
        }

        [HttpPost]
        public async Task<IActionResult> CreateOrder([FromBody] CreateOrderRequestDto request)
        {
            string token = Request.Headers["Authorization"].ToString().Split(' ')[1];
            var result = await _ordersService.CreateOrder(request);
            if (result == null)
            {
                return BadRequest();
            }

            var orderToEmail = new OrderToEmailDto
            {
                OrderId = result.OrderId,
                UserId = result.UserId,
                BarberShopId = result.BarberShopId,
                DateTime = result.DateTime,
                PaymentMethodId = result.PaymentMethodId,
                Price = result.Price,
                Status = result.Status
            };

            var barbershop = await _barberShopService.GetBarberShopById(result.BarberShopId, token);
            orderToEmail.BarberShop = barbershop;

            var email = await _barberShopService.GetUserModelById(result.UserId, token);
            orderToEmail.Email = email;

            await _messageBus.PublishMessage(orderToEmail, _configuration.GetValue<string>("TopicAndQueueNames:EmailOrderBarber"));
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
