using BarberSchedule.Services.AuthAPI.Dto;
using BarberSchedule.Services.AuthAPI.Dto.Requests;
using BarberSchedule.Services.AuthAPI.Models;

namespace BarberSchedule.Services.AuthAPI.Services.Interface
{
    public interface IAuthService
    {
        Task<LoginResponseUserDto> LoginClient(LoginClientRequest request);
        Task<string> RegisterClient(RegisterClientRequestDto request);
        Task<string> RegisterBarberShop(RegisterBarberShopRequestDTO request);
        Task<LoginBarberShopResponseDto> LoginBarberShop(LoginBarberShopRequestDto request);

        Task<string> GetUserToken(UserModel userModel);
        Task<string> GetEmailByUser(string userId);
    }
}
