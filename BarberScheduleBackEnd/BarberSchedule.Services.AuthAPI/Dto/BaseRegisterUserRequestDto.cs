﻿namespace BarberSchedule.Services.AuthAPI.Dto
{
    public abstract class BaseRegisterUserRequestDto
    {
        public string Email { get; set; }
        public string Name { get; set; }
        public string PhoneNumber { get; set; }
        public string Password { get; set; }
        public string RoleName { get; set; }

    }
}
