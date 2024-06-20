using BarberSchedule.MessageBus;
using BarberSchedule.Services.OrdersAPI.Dto;
using BarberSchedule.Services.OrdersAPI.Dto.QueryParameters;
using BarberSchedule.Services.OrdersAPI.Dto.Request;
using BarberSchedule.Services.OrdersAPI.Services.Interfaces;
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
        public IAuthService _authService { get; set; }
        public IMessageBus _messageBus { get; set; }
        public IConfiguration _configuration { get; set; }
        public OrdersController(
            IOrdersService ordersService,
            IBarberShopService barberShopService,
            IMessageBus messageBus,
            IConfiguration configuration,
            IAuthService authService)
        {
            _ordersService = ordersService;
            _barberShopService = barberShopService;
            _messageBus = messageBus;
            _configuration = configuration;
            _authService = authService;

        }

        [HttpPost("Create")]
        public async Task<IActionResult> CreateOrder([FromBody] CreateOrderRequestDto request)
        {
            string token = Request.Headers["Authorization"].ToString().Split(' ')[1];

            var email = await _authService.GetEmailByUserId(request.UserId);

            var barberShop = await _barberShopService.GetBarberShopById(request.BarberShopId,token);
            if(barberShop == null)
            {
                return BadRequest();
            }

            if (string.IsNullOrEmpty(email))
            {
                return BadRequest();
            }

            var result = await _ordersService.CreateOrder(request);
            if (result == null)
            {
                return BadRequest();
            }

            return Created();
        }

        [Authorize(Roles = "BARBERSHOP")]
        [HttpPost("ChangeStatus")]
        public async Task<IActionResult> ChangeOrderStatus([FromBody] ChangeOrderStatusRequest request)
        {
            string token = Request.Headers["Authorization"].ToString().Split(' ')[1];
            var result = await _ordersService.ChangeOrderStatus(request);
            if(result == null)
            {
                return BadRequest();
            }
            if(request.NewStatus.ToLower() == "confirmed")
            {
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

                var email = await _authService.GetEmailByUserId(result.UserId);
                orderToEmail.Email = email;
                await _messageBus.PublishMessage(orderToEmail, _configuration.GetValue<string>("TopicAndQueueNames:EmailOrderBarber"));
            }

            return Ok();
        }

        [Authorize(Roles = "CLIENT")]
        [HttpGet("GetCurrentOrder")]
        public async Task<IActionResult> GetCurrentOrder([FromQuery] GetCurrentOrderQueryParameter queryParameter)
        {
            string token = Request.Headers["Authorization"].ToString().Split(' ')[1];
            var result = await _ordersService.GetCurrentOrder(queryParameter.UserId);
            if(result == null)
            {
                return NotFound();
            }
            var result2 = await _barberShopService.GetBarberShopById(result.BarberShopId, token);
            result.BarberShop = result2;
            return Ok(result);
        }



        [Authorize(Roles = "CLIENT")]
        [HttpGet("GetByUserId")]
        public async Task<IActionResult> GetOrdersByUserId([FromQuery] GetOrderByUserIdQueryParameter queryParameter)
        {
            string token = Request.Headers["Authorization"].ToString().Split(' ')[1];
            var result = await _ordersService.GetOrderByUserId(queryParameter.UserId,queryParameter.Status);
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

        [Authorize(Roles = "BARBERSHOP")]
        [HttpGet("GetByBarberShopId")]

        public async Task<IActionResult> GetOrdersByBarberShopId([FromQuery] GetOrdersByBarberShopIdQueryParameter queryParameter)
        {
            string token = Request.Headers["Authorization"].ToString().Split(' ')[1];
            var result = await _ordersService.GetOrdersByBarberShopId(queryParameter.BarberShopId, queryParameter.Status);
            if (result == null)
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
