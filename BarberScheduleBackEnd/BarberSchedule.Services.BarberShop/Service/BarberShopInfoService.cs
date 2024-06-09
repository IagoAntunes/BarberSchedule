using AutoMapper;
using BarberSchedule.Services.AuthAPI.Data;
using BarberSchedule.Services.BarberShop.Dto;
using BarberSchedule.Services.BarberShop.Models;
using BarberSchedule.Services.BarberShop.Service.Interfaces;

namespace BarberSchedule.Services.BarberShop.Service
{
    public class BarberShopInfoService : IBarberShopInfoService
    {
        private readonly BarberShopInfoDbContext _dbContext;
        private readonly IMapper _mapper;

        public BarberShopInfoService(
            BarberShopInfoDbContext dbContext,
            IMapper mapper)
        {
            _dbContext = dbContext;
            _mapper = mapper;
        }

        public async Task CreateBarberShopInfo(BarberShopInfoDto request)
        {
            var barberShopModel = _mapper.Map<BarberShopInfoModel>(request);

            await _dbContext.BarberShopInfo.AddAsync(barberShopModel);
            await _dbContext.SaveChangesAsync();
        }
    }
}
