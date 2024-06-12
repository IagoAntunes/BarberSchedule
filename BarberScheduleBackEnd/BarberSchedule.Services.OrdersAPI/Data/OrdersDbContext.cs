using BarberSchedule.Services.OrdersAPI.Models;
using Microsoft.EntityFrameworkCore;

namespace BarberSchedule.Services.OrdersAPI.Data
{
    public class OrdersDbContext : DbContext
    {
        public OrdersDbContext(DbContextOptions<OrdersDbContext> dbContextOptions) : base(dbContextOptions)
        {
            
        }

        public DbSet<OrderModel> Orders { get; set; }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            base.OnModelCreating(modelBuilder);
            modelBuilder.Entity<OrderModel>()
            .Property(o => o.OrderId)
            .ValueGeneratedOnAdd();
        }

    }
}
