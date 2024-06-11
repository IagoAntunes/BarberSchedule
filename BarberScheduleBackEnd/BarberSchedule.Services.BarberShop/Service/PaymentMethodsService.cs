using AutoMapper;
using BarberSchedule.Services.AuthAPI.Data;
using BarberSchedule.Services.BarberShop.Dto;
using BarberSchedule.Services.BarberShop.Service.Interfaces;
using Microsoft.EntityFrameworkCore;

namespace BarberSchedule.Services.BarberShop.Service
{
    public class PaymentMethodsService : IPaymentMethodsService
    {
        private readonly BarberShopInfoDbContext _dbContext;
        private readonly IMapper _mapper;

        public PaymentMethodsService(
            BarberShopInfoDbContext dbContext,
            IMapper mapper)
        {
            _dbContext = dbContext;
            _mapper = mapper;
        }

        public async Task<ICollection<PaymentMethodDto>> GetAllPaymentMethods()
        {
            var paymentMethods = await _dbContext.PaymentMethods.ToListAsync();

            return _mapper.Map<ICollection<PaymentMethodDto>>(paymentMethods);
        }
    }
}
