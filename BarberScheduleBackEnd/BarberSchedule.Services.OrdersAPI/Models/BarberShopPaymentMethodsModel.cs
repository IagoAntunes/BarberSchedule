using System.ComponentModel.DataAnnotations;

namespace BarberSchedule.Services.OrdersAPI.Models
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
