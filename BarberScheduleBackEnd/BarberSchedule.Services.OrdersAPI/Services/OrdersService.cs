using AutoMapper;
using BarberSchedule.Services.OrdersAPI.Data;
using BarberSchedule.Services.OrdersAPI.Dto;
using BarberSchedule.Services.OrdersAPI.Dto.Request;
using BarberSchedule.Services.OrdersAPI.Migrations;
using BarberSchedule.Services.OrdersAPI.Models;
using BarberSchedule.Services.OrdersAPI.Services.Interfaces;
using Microsoft.EntityFrameworkCore;
using Microsoft.IdentityModel.Tokens;

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
        public async Task<GetOrderResponseDto?> CreateOrder(CreateOrderRequestDto request)
        {
            try
            {
                var orderModel = _mapper.Map<OrderModel>(request);
                //?? Validar UserId
                //?? Validar BarberShopId

                await _dbCOntext.Orders.AddAsync(orderModel);
                await _dbCOntext.SaveChangesAsync();

                return _mapper.Map<GetOrderResponseDto>(orderModel);
            }
            catch(Exception e)
            {
                return null;
            }
        }

        public async Task<ICollection<GetOrderResponseDto>> GetOrderByUserId(string userId,string? status)
        {
            var ordersList = await _dbCOntext.Orders
                .Where(x => x.UserId == userId)
                .ToListAsync();

            if(status != null)
            {
                ordersList = ordersList.Where(x => x.Status.ToLower() == status.ToLower()).ToList();
            }

            var barberShopDto = _mapper.Map<ICollection<GetOrderResponseDto>>(ordersList);
            return barberShopDto;
        }

        public async  Task<GetOrderResponseDto?> ChangeOrderStatus(ChangeOrderStatusRequest request)
        {
            var order = _dbCOntext.Orders.FirstOrDefault(x => x.OrderId == request.OrderId);

            if(order == null)
            {
                return null;
            }

            order.Status = request.NewStatus;
            await _dbCOntext.SaveChangesAsync();
            
            return _mapper.Map<GetOrderResponseDto>(order);
        }

        public async Task<ICollection<GetOrderResponseDto>> GetOrdersByBarberShopId(object barberShopId, string? status)
        {
            var ordersList = await _dbCOntext.Orders
                .Where(x => x.BarberShopId == barberShopId)
                .ToListAsync();

            if (status != null)
            {
                ordersList = ordersList.Where(x => x.Status.ToLower() == status.ToLower()).ToList();
            }

            var response = _mapper.Map<ICollection<GetOrderResponseDto>>(ordersList);
            return response;
        }

        public async Task<GetCurrentOrderResponse?> GetCurrentOrder(string userId)
        {
            var orders = await _dbCOntext.Orders
                   .Where(x => x.UserId == userId).ToListAsync();
            if (orders == null)
            {
                return null;
            }
            List<OrderModel> auxList = [];
            foreach(var order in orders)
            {
                if(DateTime.Parse(order.DateTime) > DateTime.Now)
                {
                    auxList.Add(order);
                }
            }
            if(auxList.IsNullOrEmpty())
            {
                return null;
            }
            auxList.OrderByDescending(x => DateTime.Parse(x.DateTime));

            var responseDto = _mapper.Map<GetCurrentOrderResponse>(auxList.First());

            return responseDto;
        }
    }
}
