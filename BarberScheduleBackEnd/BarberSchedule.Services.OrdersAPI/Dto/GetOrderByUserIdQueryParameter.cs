﻿namespace BarberSchedule.Services.OrdersAPI.Dto
{
    public class GetOrderByUserIdQueryParameter
    {
        public string UserId { get; set; }
        public string? Status { get; set; }
    }
}
