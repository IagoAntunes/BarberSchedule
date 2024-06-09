using BarberSchedule.Services.AuthAPI.Dto;
using BarberSchedule.Services.AuthAPI.Services.Interface;
using Microsoft.AspNetCore.Mvc;

namespace BarberSchedule.Services.AuthAPI.Controllers
{

    [Route("api/auth")]
    [ApiController]
    public class AuthApiController : ControllerBase
    {
        public readonly IAuthService _authService;
        public readonly ResponseDto _response;

        public AuthApiController(IAuthService authService)
        {
            _authService = authService;
            _response = new ResponseDto();
        }

        [HttpPost("register/client")]

        public async Task<IActionResult> Register(RegisterClientRequestDto request)
        {
            var result = await _authService.RegisterClient(request);
            if (!string.IsNullOrEmpty(result))
            {
                _response.IsSuccesful = false;
                _response.Message = result;
                return BadRequest();
            }
            return Ok(result);
        }
        [HttpPost("register/barberShop")]

        public async Task<IActionResult> RegisterBarberShop(RegisterBarberShopRequestDTO request)
        {
            var result = await _authService.RegisterBarberShop(request);
            if (!string.IsNullOrEmpty(result))
            {
                _response.IsSuccesful = false;
                _response.Message = result;
                return BadRequest();
            }
            return Ok(result);
        }
    }
}
