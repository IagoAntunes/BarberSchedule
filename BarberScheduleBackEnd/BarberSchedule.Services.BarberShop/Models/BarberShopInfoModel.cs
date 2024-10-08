﻿using System.ComponentModel.DataAnnotations;

namespace BarberSchedule.Services.BarberShop.Models
{
    public class BarberShopInfoModel
    {
        [Key]
        public int Id { get; set; }
        public string UserId { get; set; }
        public string Name { get; set; }
        public string Description { get; set; }
        public string PhoneNumber { get; set; }
        public string State { get; set; }
        public string City { get; set; }
        public string Number { get; set; }
        public string Photo { get; set; }
        public string AvailableTimes { get; set; }
        public double Price { get; set; }

        public ICollection<BarberShopPaymentMethodsModel> BarberShopPaymentMethods { get; set; }
    }
}
