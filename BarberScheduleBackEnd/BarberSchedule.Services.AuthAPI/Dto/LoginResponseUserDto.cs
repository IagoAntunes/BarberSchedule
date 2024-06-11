namespace BarberSchedule.Services.AuthAPI.Dto
{
    public class LoginResponseUserDto
    {
        public UserDto User { get; set; }
        public string Token { get; set; }
    }
}
