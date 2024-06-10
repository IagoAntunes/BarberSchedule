using AutoMapper;
using BarberSchedule.Services.AuthAPI.Data;
using BarberSchedule.Services.BarberShop.Dto;
using BarberSchedule.Services.BarberShop.Models;
using BarberSchedule.Services.BarberShop.Service.Interfaces;
using Microsoft.EntityFrameworkCore;
using System.Text.RegularExpressions;

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

        public async Task CreateBarberShopInfo(CreateBarberShopInfoDto request)
        {
            var barberShopModel = _mapper.Map<BarberShopInfoModel>(request);

            var addedBarberShop = await _dbContext.BarberShopInfo.AddAsync(barberShopModel);
            await _dbContext.SaveChangesAsync();

            if (!string.IsNullOrEmpty(request.Photo))
            {
                var b64 = "";
                var dataPrefixPattern = @"^data:image\/[a-zA-Z]+;base64,";
                b64 = Regex.Replace(request.Photo, dataPrefixPattern, string.Empty);
                byte[] imageBytes = Convert.FromBase64String(b64);

                string fileName = barberShopModel.Id +  barberShopModel.Name + ".png";
                string filePath = @"wwwroot\BarberShopImages\" + fileName;
                // Caminho completo do arquivo
                var filePathDirectory = Path.Combine(Directory.GetCurrentDirectory(), filePath);

                // Salvar o arquivo
                await System.IO.File.WriteAllBytesAsync(filePathDirectory, imageBytes);
            }

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

        public async Task<BarberShopInfoDto?> GetByUserIdBarberShopInfo(GetByUserIdBarberShopRequest request)
        {
            var barberShop = await _dbContext.BarberShopInfo
                .Include(b => b.BarberShopPaymentMethods)
                    .ThenInclude(bp => bp.PaymentMethod)
                    .FirstOrDefaultAsync(x => x.UserId == request.UserId);

            if (barberShop != null)
            {
                return _mapper.Map<BarberShopInfoDto>(barberShop);
            }
            return null;
        }
    }
}
