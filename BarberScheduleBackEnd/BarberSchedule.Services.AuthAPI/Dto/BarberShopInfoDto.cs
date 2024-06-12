namespace BarberSchedule.Services.BarberShop.Dto
{
    public class BarberShopInfoDto
    {
        public string UserId { get; set; }
        public string Name { get; set; }
        public string Description { get; set; }
        public string PhoneNumber { get; set; }
        public string State { get; set; }
        public string City { get; set; }
        public string Number { get; set; }
        public string Photo { get; set; }
        public string AvailableTimes { get; set; }
        public double Price { get; set; }
        public ICollection<PaymentMethodDto> PaymentMethods { get; set; }

    }
}
