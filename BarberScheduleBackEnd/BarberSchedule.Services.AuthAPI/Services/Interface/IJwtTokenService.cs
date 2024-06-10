using BarberSchedule.Services.AuthAPI.Models;

namespace BarberSchedule.Services.AuthAPI.Services.Interface
{
    public interface IJwtTokenService
    {
        string CreateToken(UserModel user);
    }
}
