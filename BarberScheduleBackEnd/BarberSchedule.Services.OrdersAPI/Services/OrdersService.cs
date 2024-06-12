using AutoMapper;
using BarberSchedule.Services.OrdersAPI.Data;
using BarberSchedule.Services.OrdersAPI.Dto;
using BarberSchedule.Services.OrdersAPI.Models;
using Microsoft.EntityFrameworkCore;

namespace BarberSchedule.Services.OrdersAPI.Services
{
    public class OrdersService : IOrdersService
    {
        public OrdersDbContext _dbCOntext { get; set; }
        public IMapper _mapper { get; set; }

        public OrdersService(
            OrdersDbContext ordersDbContext,
            IMapper mapper)
        {
            _dbCOntext = ordersDbContext;
            _mapper = mapper;
        }
        public async Task<bool> CreateOrder(CreateOrderRequestDto request)
        {
            try
            {
                var orderModel = _mapper.Map<OrderModel>(request);
                //?? Validar UserId
                //?? Validar BarberShopId

                await _dbCOntext.Orders.AddAsync(orderModel);
                await _dbCOntext.SaveChangesAsync();

                return true;
            }
            catch(Exception e)
            {
                return false;
            }
        }

        public async Task<ICollection<GetOrderResponseDto>> GetOrderByUserId(string userId)
        {
            var barbersShop = await _dbCOntext.Orders
                .Where(x => x.UserId == userId)
                .ToListAsync();

            var barberShopDto = _mapper.Map<ICollection<GetOrderResponseDto>>(barbersShop);
            return barberShopDto;
        }
    }
}
