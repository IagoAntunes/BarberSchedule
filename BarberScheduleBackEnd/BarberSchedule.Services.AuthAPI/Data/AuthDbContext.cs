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

        protected override void OnModelCreating(ModelBuilder builder)
        {
            base.OnModelCreating(builder);
            var readerRoleId = "ea43887c-e3d9-47bf-b8cd-72f01cb65146";
            var writerRoleId = "8e6219e5-c54c-4c3d-a58b-ccf0001d6636";

            var roles = new List<IdentityRole>
            {
                new IdentityRole
                {
                    Id = readerRoleId,
                    ConcurrencyStamp = readerRoleId,
                    Name = "BARBERSHOP",
                    NormalizedName = "BARBERSHOP"
                },
                new IdentityRole
                {
                    Id = writerRoleId,
                    ConcurrencyStamp = writerRoleId,
                    Name = "CLIENT",
                    NormalizedName = "CLIENT"
                }
            };

            builder.Entity<IdentityRole>().HasData(roles);
        }
    }
}
