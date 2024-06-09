using BarberSchedule.Services.AuthAPI.Dto;
using BarberSchedule.Services.AuthAPI.Models;
using BarberSchedule.Services.AuthAPI.Services.Interface;
using Newtonsoft.Json;
using System.Net.Http;
using System.Text;

namespace BarberSchedule.Services.AuthAPI.Services
{
    public class BarberShopInfoService : IBarberShopInfoService
    {
        private readonly IHttpClientFactory _httpClientFactory;
        private readonly IConfiguration _configuration;

        public BarberShopInfoService(
            IHttpClientFactory httpClientFactory,
            IConfiguration configuration)
        {
            _httpClientFactory = httpClientFactory;
            _configuration = configuration;

        }
        public async Task<bool> CreateBarberShop(BarberShopInfoModel barberShopInfoModel)
        {
            var client = _httpClientFactory.CreateClient("BarberShopAPI");
            var barberShopApiUrl = _configuration["ServiceUrls:BarberShopInfoAPI"];
            var jsonContent = JsonConvert.SerializeObject(barberShopInfoModel);
            var content = new StringContent(jsonContent, Encoding.UTF8, "application/json");

            var response = await client.PostAsync($"{barberShopApiUrl}/api/bARBERshopInfo", content);

            return response.IsSuccessStatusCode;
        }
    }
}
