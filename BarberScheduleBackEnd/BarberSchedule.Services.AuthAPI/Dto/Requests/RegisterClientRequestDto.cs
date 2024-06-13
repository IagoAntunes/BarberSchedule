namespace BarberSchedule.Services.AuthAPI.Dto.Requests
{
    public class RegisterClientRequestDto : BaseRegisterUserRequestDto
    {
        public string Photo { get; set; }
    }
}
