using BarberSchedule.Services.BarberShop.Dto;

namespace BarberSchedule.Services.BarberShop.Service.Interfaces
{
    public interface IBarberShopInfoService
    {
        Task CreateBarberShopInfo(CreateBarberShopInfoDto request);
        Task<BarberShopInfoDto?> GetByIdBarberShopInfo(GetBarberShopInfoRequest request);
        Task<BarberShopInfoDto?> GetByUserIdBarberShopInfo(GetByUserIdBarberShopRequest request);
        Task<IEnumerable<BarberShopInfoDto>> GetAllBarberShopInfo();
    }
}
