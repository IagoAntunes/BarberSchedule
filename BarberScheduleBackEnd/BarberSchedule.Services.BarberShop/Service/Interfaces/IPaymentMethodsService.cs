using BarberSchedule.Services.BarberShop.Dto;

namespace BarberSchedule.Services.BarberShop.Service.Interfaces
{
    public interface IPaymentMethodsService
    {
        Task<ICollection<PaymentMethodDto>> GetAllPaymentMethods();
    }
}
