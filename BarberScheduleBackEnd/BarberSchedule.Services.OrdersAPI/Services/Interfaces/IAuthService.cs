namespace BarberSchedule.Services.OrdersAPI.Services.Interfaces
{
    public interface IAuthService
    {
        Task<string> GetEmailByUserId(string userId);
    }
}
