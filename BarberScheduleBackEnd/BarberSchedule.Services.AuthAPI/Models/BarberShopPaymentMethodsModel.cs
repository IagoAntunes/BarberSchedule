using BarberSchedule.Services.AuthAPI.Models;
using System.ComponentModel.DataAnnotations;

namespace BarberSchedule.Services.BarberShop.Models
{
    public class BarberShopPaymentMethodsModel
    {
        [Key]
        public int Id { get; set; }
        public int BarberShopId { get; set; }
        public BarberShopInfoModel BarberShop { get; set; }

        public int PaymentMethodId { get; set; }
        public PaymentMethodModel PaymentMethod { get; set; }
    }

}
