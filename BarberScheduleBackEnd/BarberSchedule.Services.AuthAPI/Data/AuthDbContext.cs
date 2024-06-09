using BarberSchedule.Services.AuthAPI.Models;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Identity.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore;

namespace BarberSchedule.Services.AuthAPI.Data
{
    public class AuthDbContext : IdentityDbContext<UserModel>
    {

        public AuthDbContext(DbContextOptions options) : base(options)
        {
        }
        public DbSet<UserModel> Users { get; set; }
    }
}
