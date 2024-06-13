namespace BarberSchedule.Services.OrdersAPI.Dto.Request
{
    public class CreateOrderRequestDto
    {
        public string UserId { get; set; }
        public string BarberShopId { get; set; }
        public string DateTime { get; set; }
        public string PaymentMethodId { get; set; }
        public double Price { get; set; }
        public string Status { get; set; }// Waiting, Confirmed, Canceled
    }
}
