namespace BarberSchedule.Services.EmailAPI.Dto
{
    public class OrderToEmailDto
    {
        public string OrderId { get; set; }
        public string UserId { get; set; }
        public string BarberShopId { get; set; }
        public string DateTime { get; set; }
        public string PaymentMethodId { get; set; }
        public double Price { get; set; }
        public string Status { get; set; }// Waiting, Confirmed, Canceled

        //Navigation
        public BarberShopInfoDto BarberShop { get; set; }
        public string Email { get; set; }
    }
}
