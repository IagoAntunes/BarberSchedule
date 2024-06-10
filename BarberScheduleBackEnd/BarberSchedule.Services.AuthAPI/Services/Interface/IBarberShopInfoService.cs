using BarberSchedule.Services.AuthAPI.Models;
using BarberSchedule.Services.BarberShop.Dto;

namespace BarberSchedule.Services.AuthAPI.Services.Interface
{
    public interface IBarberShopInfoService
    {

        Task<bool> CreateBarberShop(CreateBarberShopInfoDto barberShopInfoModel,string token);
        Task<BarberShopInfoDto?> GetBarberShopInfo(UserModel barberShop,string token);
    }   
}
