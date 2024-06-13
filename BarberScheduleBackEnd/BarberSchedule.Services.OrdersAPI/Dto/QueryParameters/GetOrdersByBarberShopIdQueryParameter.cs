namespace BarberSchedule.Services.OrdersAPI.Dto.QueryParameters
{
    public class GetOrdersByBarberShopIdQueryParameter
    {
        public string BarberShopId { get; set; }
        public string? Status { get; set; }
    }
}
