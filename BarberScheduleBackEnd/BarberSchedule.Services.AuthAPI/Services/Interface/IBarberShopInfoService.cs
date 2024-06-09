using BarberSchedule.Services.AuthAPI.Models;

namespace BarberSchedule.Services.AuthAPI.Services.Interface
{
    public interface IBarberShopInfoService
    {

        Task<bool> CreateBarberShop(BarberShopInfoModel barberShopInfoModel);
    }   
}
