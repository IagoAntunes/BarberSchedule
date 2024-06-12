using Microsoft.AspNetCore.Identity;

namespace BarberSchedule.Services.OrdersAPI.Models
{
    public class UserModel : IdentityUser
    {
        public string Photo { get; set; }
    }
}
