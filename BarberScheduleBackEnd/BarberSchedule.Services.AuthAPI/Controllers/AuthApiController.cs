using Azure;
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

        [HttpPost("login/client")]
        public async Task<IActionResult> LoginClient([FromBody] LoginClientRequest request)
        {
            var result = await _authService.LoginClient(request);
            if(result.User == null)
            {
                _response.IsSuccesful = false;
                _response.Message = "Invalid email or password";
                return BadRequest(_response);
            }
            return Ok(result);
        }
        [HttpPost("login/barberShop")]
        public async Task<IActionResult> LoginBarberShop([FromBody] LoginBarberShopRequestDto request)
        {
            var result = await _authService.LoginBarberShop(request);
            if(result.BarberShop == null)
            {
                _response.IsSuccesful = false;
                return BadRequest();
            }
            return Ok(result);
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

        [HttpGet("GetEmailByUser")]
        public async Task<IActionResult> GetEmailByUser([FromQuery] string userId)
        {
            var result = await _authService.GetEmailByUser(userId);
            var response = new GetEmailByUserResponseDto()
            {
                Email = result
            };
            return Ok(response);
        }
        
    }
}
