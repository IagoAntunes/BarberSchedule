
using BarberSchedule.Services.OrdersAPI.Dto;
using Newtonsoft.Json;
using System.Net.Http.Headers;

namespace BarberSchedule.Services.OrdersAPI.Services
{
    public class AuthService : IAuthService
    {
        public IHttpClientFactory _httpClientFactory { get; set; }
        public IConfiguration _configuration { get; set; }

        public AuthService(
            IConfiguration configuration,
            IHttpClientFactory httpClientFactory)
        {
            _httpClientFactory = httpClientFactory;
            _configuration = configuration;
        }

        public async Task<string> GetEmailByUserId(string userId)
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
