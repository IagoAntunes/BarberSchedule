using BarberSchedule.Services.BarberShop.Dto;

namespace BarberSchedule.Services.AuthAPI.Dto
{
    public class LoginBarberShopResponseDto
    {
        public BarberShopInfoDto BarberShop { get; set; }
        public string Token { get; set; }
    }
}
