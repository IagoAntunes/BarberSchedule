using BarberSchedule.Services.EmailAPI.Data;
using BarberSchedule.Services.EmailAPI.Dto;
using BarberSchedule.Services.EmailAPI.Models;
using BarberSchedule.Services.EmailAPI.Service.Interfaces;
using Microsoft.AspNetCore.SignalR;
using Microsoft.EntityFrameworkCore;
using System;
using System.Text;

namespace BarberSchedule.Services.EmailAPI.Service
{
    public class EmailService : IEmailService
    {
        private DbContextOptions<EmailDbContext> _dbOptions;

        public EmailService(DbContextOptions<EmailDbContext> dbOptions)
        {
            _dbOptions = dbOptions;
        }
        public async Task EmailCartAndLog(OrderToEmailDto orderToEmail)
        {
            StringBuilder message = new StringBuilder();

            message.AppendLine("<br/>Order Requested");
            message.AppendLine("<br/>Total" + orderToEmail.Price);
            message.Append("<br/>");
            message.Append("<ul>");

            message.Append("</ul");

            await LogAndEmail(message.ToString(), orderToEmail.Email);
        }

        private async Task<bool> LogAndEmail(string message, string email)
        {
            try
            {
                EmailLogger emailLog = new()
                {
                    Email = email,
                    EmailSent = DateTime.Now,
                    Message = message
                };

                await using var _db = new EmailDbContext(_dbOptions);

                await _db.EmailLogger.AddAsync(emailLog);
                await _db.SaveChangesAsync();

                return true;
            }
            catch
            {
                return false;
            }
        }
    }
}
