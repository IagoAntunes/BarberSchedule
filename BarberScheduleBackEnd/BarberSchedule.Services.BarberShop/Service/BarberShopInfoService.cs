using AutoMapper;
using BarberSchedule.Services.AuthAPI.Data;
using BarberSchedule.Services.BarberShop.Dto;
using BarberSchedule.Services.BarberShop.Models;
using BarberSchedule.Services.BarberShop.Service.Interfaces;
using Microsoft.EntityFrameworkCore;

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

            var addedBarberShop = await _dbContext.BarberShopInfo.AddAsync(barberShopModel);
            await _dbContext.SaveChangesAsync();

            foreach (var paymentMethod in request.PaymentMethods)
            {
                var barberShopPaymentMethod = new BarberShopPaymentMethodsModel()
                {
                    BarberShopId = addedBarberShop.Entity.Id,
                    PaymentMethodId = paymentMethod
                };
                _dbContext.BarberShopPaymentMethods.Add(barberShopPaymentMethod);
            };
            await _dbContext.SaveChangesAsync();
        }

        public async Task<IEnumerable<BarberShopInfoDto>> GetAllBarberShopInfo()
        {
            var barberShops = await _dbContext.BarberShopInfo
                .Include(b => b.BarberShopPaymentMethods)
                    .ThenInclude(bp => bp.PaymentMethod)
                    .ToListAsync();

            return _mapper.Map<IEnumerable<BarberShopInfoDto>>(barberShops);
        }

        public async Task<BarberShopInfoDto?> GetByIdBarberShopInfo(GetBarberShopInfoRequest request)
        {
            var barberShop = await _dbContext.BarberShopInfo.FirstOrDefaultAsync(x => x.Id == request.BarberShopId);
            
            if(barberShop != null)
            {
                return _mapper.Map<BarberShopInfoDto>(barberShop);
            }
            return null;
        
        }
    }
}
