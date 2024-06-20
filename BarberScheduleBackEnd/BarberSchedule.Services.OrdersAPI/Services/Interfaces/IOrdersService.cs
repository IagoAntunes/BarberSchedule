using BarberSchedule.Services.OrdersAPI.Dto;
using BarberSchedule.Services.OrdersAPI.Dto.Request;

namespace BarberSchedule.Services.OrdersAPI.Services.Interfaces
{
    public interface IOrdersService
    {
        Task<GetOrderResponseDto?> ChangeOrderStatus(ChangeOrderStatusRequest request);
        Task<GetOrderResponseDto?> CreateOrder(CreateOrderRequestDto request);
        Task<GetOrderResponseDto?> GetCurrentOrder(string userId);
        Task<ICollection<GetOrderResponseDto>> GetOrderByUserId(string userId, string? status);
        Task<ICollection<GetOrderResponseDto>> GetOrdersByBarberShopId(object barberShopId, string? status);
    }
}
