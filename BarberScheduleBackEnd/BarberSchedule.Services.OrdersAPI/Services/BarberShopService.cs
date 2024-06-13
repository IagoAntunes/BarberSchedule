using BarberSchedule.Services.OrdersAPI.Dto;
using BarberSchedule.Services.OrdersAPI.Models;
using Microsoft.AspNetCore.Identity;
using Newtonsoft.Json;
using System.Net.Http.Headers;
using System.Text;

namespace BarberSchedule.Services.OrdersAPI.Services
{
    public class BarberShopService : IBarberShopService
    {
        public IHttpClientFactory _httpClientFactory { get; set; }
        public IConfiguration _configuration { get; set; }

        public BarberShopService(
            IHttpClientFactory httpClientFactory,
            IConfiguration configuration)
        {
            _httpClientFactory = httpClientFactory;
            _configuration = configuration;
        }

        public async Task<BarberShopInfoDto?> GetBarberShopById(string barberShopId,string token)
        {
            var client = _httpClientFactory.CreateClient("BarberShopAPI");
            var barberShopApiUrl = _configuration["ServiceUrls:BarberShopInfoAPI"];

            // Adicione o token JWT no cabeçalho de autorização
            client.DefaultRequestHeaders.Authorization = new AuthenticationHeaderValue("Bearer", token);
            var response = await client.GetAsync($"{barberShopApiUrl}/api/BarberShopInfo/GetById?BarberShopId={barberShopId}");
            if (response.IsSuccessStatusCode)
            {
                // Lendo o conteúdo da resposta como string
                var jsonResponse = await response.Content.ReadAsStringAsync();
                // Desserializando a resposta JSON para o objeto BarberShopInfoDto
                var barberShopInfo = JsonConvert.DeserializeObject<BarberShopInfoDto?>(jsonResponse);
                return barberShopInfo;
            }
            return null;
        }

        public async Task<string> GetUserModelById(string userId, string token)
        {
            var client = _httpClientFactory.CreateClient("BarberShopAPI");
            var baseAuthApiUrl = _configuration["ServiceUrls:BaseAuthApiUrl"];

            var response = await client.GetAsync($"{baseAuthApiUrl}/api/auth/GetEmailByUser?userId={userId}");
            if (response.IsSuccessStatusCode)
            {
                var jsonResponse = await response.Content.ReadAsStringAsync();
                var email = JsonConvert.DeserializeObject<GetEmailByUserResponseDto?>(jsonResponse);
                return email.Email;
            }
            return "";
        }
    }
}
