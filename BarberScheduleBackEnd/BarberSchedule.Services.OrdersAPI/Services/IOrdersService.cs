using BarberSchedule.Services.OrdersAPI.Dto;

namespace BarberSchedule.Services.OrdersAPI.Services
{
    public interface IOrdersService
    {
        Task<GetOrderResponseDto?> CreateOrder(CreateOrderRequestDto request);
        Task<ICollection<GetOrderResponseDto>> GetOrderByUserId(string userId);
    }
}
