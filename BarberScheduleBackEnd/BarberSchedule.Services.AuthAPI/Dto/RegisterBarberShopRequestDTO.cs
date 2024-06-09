namespace BarberSchedule.Services.AuthAPI.Dto
{
    public class RegisterBarberShopRequestDTO : BaseRegisterUserRequestDto
    {
        public string Name { get; set; }
        public string Description { get; set; }
        public string State { get; set; }
        public string City { get; set; }
        public string Number { get; set; }
        public string Photo { get; set; }
        public string AvailableTimes { get; set; }
    }
}
