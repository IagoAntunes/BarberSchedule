using Microsoft.AspNetCore.Identity;

namespace BarberSchedule.Services.AuthAPI.Models
{
    public class UserModel : IdentityUser
    {
        public string Photo { get; set; }
    }
}
