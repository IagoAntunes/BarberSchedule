namespace BarberSchedule.Services.OrdersAPI.Dto
{
    public class ChangeOrderStatusRequest
    {
        public string OrderId { get; set; }
        public string NewStatus { get; set; }
    }
}
