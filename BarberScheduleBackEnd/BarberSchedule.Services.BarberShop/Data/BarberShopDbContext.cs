using BarberSchedule.Services.BarberShop.Models;
using Microsoft.EntityFrameworkCore;

namespace BarberSchedule.Services.AuthAPI.Data
{
    public class BarberShopInfoDbContext : DbContext
    {

        public BarberShopInfoDbContext(DbContextOptions<BarberShopInfoDbContext> options) : base(options)
        {
            
        }
        public DbSet<BarberShopInfoModel> BarberShopInfo { get; set; }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            base.OnModelCreating(modelBuilder);
        }
    }
}
