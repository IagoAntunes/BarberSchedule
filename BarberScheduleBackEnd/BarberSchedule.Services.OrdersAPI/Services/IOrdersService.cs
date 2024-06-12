using BarberSchedule.Services.OrdersAPI.Dto;

namespace BarberSchedule.Services.OrdersAPI.Services
{
    public interface IOrdersService
    {
        Task<bool> CreateOrder(CreateOrderRequestDto request);
        Task<ICollection<GetOrderResponseDto>> GetOrderByUserId(string userId);
    }
}
