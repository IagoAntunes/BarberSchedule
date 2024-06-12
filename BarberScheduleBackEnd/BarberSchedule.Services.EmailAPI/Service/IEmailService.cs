using BarberSchedule.Services.EmailAPI.Dto;

namespace BarberSchedule.Services.EmailAPI.Service
{
    public interface IEmailService
    {
        Task EmailCartAndLog(OrderToEmailDto orderToEmail);
    }
}
