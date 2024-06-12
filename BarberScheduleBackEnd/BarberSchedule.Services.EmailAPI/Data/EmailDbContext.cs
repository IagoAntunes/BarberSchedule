using BarberSchedule.Services.EmailAPI.Models;
using Microsoft.EntityFrameworkCore;

namespace BarberSchedule.Services.EmailAPI.Data
{
    public class EmailDbContext : DbContext
    {
        public EmailDbContext(DbContextOptions<EmailDbContext> dbContextOptions) : base(dbContextOptions)
        {
            
        }
        public DbSet<EmailLogger> EmailLogger { get; set; }

    }
}
