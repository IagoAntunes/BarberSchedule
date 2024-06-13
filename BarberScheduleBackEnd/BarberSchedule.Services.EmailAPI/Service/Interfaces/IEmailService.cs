using BarberSchedule.Services.EmailAPI.Dto;

namespace BarberSchedule.Services.EmailAPI.Service.Interfaces
{
    public interface IEmailService
    {
        Task EmailCartAndLog(OrderToEmailDto orderToEmail);
    }
}
