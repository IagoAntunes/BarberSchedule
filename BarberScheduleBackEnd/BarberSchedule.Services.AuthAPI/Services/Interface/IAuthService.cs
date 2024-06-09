using BarberSchedule.Services.AuthAPI.Dto;

namespace BarberSchedule.Services.AuthAPI.Services.Interface
{
    public interface IAuthService
    {
        Task<LoginResponseUserDto> LoginClient(LoginClientRequest request);
        Task<string> RegisterClient(RegisterClientRequestDto request);
        Task<string> RegisterBarberShop(RegisterBarberShopRequestDTO request);
        Task<LoginBarberShopResponseDto> LoginBarberShop(LoginBarberShopRequestDto request);
    }
}
