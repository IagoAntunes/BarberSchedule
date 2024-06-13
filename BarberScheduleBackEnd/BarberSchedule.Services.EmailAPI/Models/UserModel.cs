using Microsoft.AspNetCore.Identity;

namespace BarberSchedule.Services.EmailAPI.Models
{
    public class UserModel : IdentityUser
    {
        public string Photo { get; set; }
    }
}
