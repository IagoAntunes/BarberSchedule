namespace BarberSchedule.Services.OrdersAPI.Services
{
    public interface IAuthService
    {
        Task<string> GetEmailByUserId(string userId);
    }
}
