using AutoMapper;
using BarberSchedule.Services.OrdersAPI.Dto;
using BarberSchedule.Services.OrdersAPI.Dto.Request;
using BarberSchedule.Services.OrdersAPI.Models;

namespace BarberSchedule.Services.OrdersAPI
{
    public class MappingConfig
    {

        public static MapperConfiguration? RegisterMaps()
        {
            var mappingConfig = new MapperConfiguration(
                config =>
                {
                    config.CreateMap<CreateOrderRequestDto, OrderModel>().ReverseMap();
                    config.CreateMap<GetOrderResponseDto,OrderModel>().ReverseMap();
                });


            return mappingConfig;
        }

    }
}
