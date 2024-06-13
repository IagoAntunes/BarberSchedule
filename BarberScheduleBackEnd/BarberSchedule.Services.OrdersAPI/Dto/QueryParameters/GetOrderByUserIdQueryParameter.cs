namespace BarberSchedule.Services.OrdersAPI.Dto.QueryParameters
{
    public class GetOrderByUserIdQueryParameter
    {
        public string UserId { get; set; }
        public string? Status { get; set; }
    }
}
