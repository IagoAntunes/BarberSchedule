using BarberSchedule.Services.BarberShop.Dto;
using BarberSchedule.Services.BarberShop.Service.Interfaces;
using Microsoft.AspNetCore.Mvc;

namespace BarberSchedule.Services.BarberShop.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class BarberShopInfoController : ControllerBase
    {
        private readonly IBarberShopInfoService _barberShopInfoService;

        public BarberShopInfoController(IBarberShopInfoService barberShopInfoService)
        {
            _barberShopInfoService = barberShopInfoService;
        }

        [HttpPost]
        public async Task<IActionResult> CreateBarberShopInfo([FromBody] BarberShopInfoDto request)
        {
            await _barberShopInfoService.CreateBarberShopInfo(request);

            return Ok();
        }

    }
}
