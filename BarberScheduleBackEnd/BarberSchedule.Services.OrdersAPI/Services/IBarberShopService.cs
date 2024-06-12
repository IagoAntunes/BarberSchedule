using BarberSchedule.Services.OrdersAPI.Dto;
using BarberSchedule.Services.OrdersAPI.Models;

namespace BarberSchedule.Services.OrdersAPI.Services
{
    public interface IBarberShopService
    {

        Task<BarberShopInfoDto?> GetBarberShopById(string barberShopId, string token);
        Task<string> GetUserModelById(string userId, string token);
    }
}
