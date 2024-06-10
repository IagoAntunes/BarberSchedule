using BarberSchedule.Services.AuthAPI.Models;

namespace BarberSchedule.Services.AuthAPI.Services.Interface
{
    public interface IJwtTokenService
    {
        Task<string> CreateToken(UserModel user);
    }
}
