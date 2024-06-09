using BarberSchedule.Services.AuthAPI.Dto;
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
        private readonly ResponseDto _response;

        public BarberShopInfoController(IBarberShopInfoService barberShopInfoService)
        {
            _barberShopInfoService = barberShopInfoService;
            _response = new ResponseDto();
        }

        [HttpPost("Create")]
        public async Task<IActionResult> CreateBarberShopInfo([FromBody] BarberShopInfoDto request)
        {
            await _barberShopInfoService.CreateBarberShopInfo(request);

            return Ok();
        }

        [HttpGet("GetAll")]
        public async Task<IActionResult> GetAllBarberShopInfo()
        {
            var result = await _barberShopInfoService.GetAllBarberShopInfo();
            return Ok(result);
        }

        [HttpGet("GetById")]
        public async Task<IActionResult> GetByIdBarberShopInfo([FromQuery] GetBarberShopInfoRequest request)
        {
            var result = await _barberShopInfoService.GetByIdBarberShopInfo(request);
            if(result == null)
            {
                _response.IsSuccesful = false;
                return BadRequest(_response);
            }
            return Ok(result);
        }

    }
}
