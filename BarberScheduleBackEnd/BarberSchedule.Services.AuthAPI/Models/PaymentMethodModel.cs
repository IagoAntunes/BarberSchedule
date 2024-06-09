using System.ComponentModel.DataAnnotations;

namespace BarberSchedule.Services.BarberShop.Models
{
    public class PaymentMethodModel
    {
        [Key]
        public int IdPaymentMethod { get; set; }
        public string Name { get; set; }
    }
}
