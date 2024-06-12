using BarberSchedule.Services.OrdersAPI.Dto;

namespace BarberSchedule.Services.OrdersAPI.Services
{
    public interface IBarberShopService
    {

        Task<BarberShopInfoDto?> GetBarberShopById(string barberShopId, string token);
    }
}
