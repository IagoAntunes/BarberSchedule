namespace BarberSchedule.Services.OrdersAPI.Dto
{
    public class GetOrdersByBarberShopIdQueryParameter
    {
        public string BarberShopId { get; set; }
        public string? Status { get; set; }
    }
}
