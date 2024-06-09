using BarberSchedule.Services.BarberShop.Dto;

namespace BarberSchedule.Services.BarberShop.Service.Interfaces
{
    public interface IBarberShopInfoService
    {
        Task CreateBarberShopInfo(BarberShopInfoDto request);
        Task<BarberShopInfoDto?> GetByIdBarberShopInfo(GetBarberShopInfoRequest request);
        Task<IEnumerable<BarberShopInfoDto>> GetAllBarberShopInfo();
    }
}
