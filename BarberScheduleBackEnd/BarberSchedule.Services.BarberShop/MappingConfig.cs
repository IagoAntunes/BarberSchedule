using AutoMapper;
using BarberSchedule.Services.BarberShop.Dto;
using BarberSchedule.Services.BarberShop.Models;

namespace BarberSchedule.Services.AuthAPI
{
    public class MappingConfig
    {

        public static MapperConfiguration? RegisterMaps()
        {
            var mappingConfig = new MapperConfiguration(
                config =>
                {
                    config.CreateMap<BarberShopInfoDto, BarberShopInfoModel>().ReverseMap();
                    config.CreateMap<PaymentMethodDto, PaymentMethodModel>().ReverseMap();
                });


            return mappingConfig;
        }

    }
}
