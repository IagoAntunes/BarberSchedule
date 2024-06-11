using BarberSchedule.Services.AuthAPI.Dto;
using BarberSchedule.Services.AuthAPI.Models;
using BarberSchedule.Services.AuthAPI.Services.Interface;
using BarberSchedule.Services.BarberShop.Dto;
using Newtonsoft.Json;
using System.Net.Http;
using System.Net.Http.Headers;
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
        public async Task<bool> CreateBarberShop(CreateBarberShopInfoDto barberShopInfoModel, string token)
        {
            var client = _httpClientFactory.CreateClient("BarberShopAPI");
            var barberShopApiUrl = _configuration["ServiceUrls:BarberShopInfoAPI"];
            var jsonContent = JsonConvert.SerializeObject(barberShopInfoModel);
            var content = new StringContent(jsonContent, Encoding.UTF8, "application/json");

            // Adicione o token JWT no cabeçalho de autorização
            client.DefaultRequestHeaders.Authorization = new AuthenticationHeaderValue("Bearer", token);

            var response = await client.PostAsync($"{barberShopApiUrl}/api/BarberShopInfo/Create", content);

            return response.IsSuccessStatusCode;
        }
        public async Task<BarberShopInfoDto?> GetBarberShopInfo(UserModel barberShop,string token)
        {
            // Obtendo o cliente HTTP
            var client = _httpClientFactory.CreateClient("BarberShopAPI");
            // Obtendo a URL base da API a partir da configuração
            var barberShopApiUrl = _configuration["ServiceUrls:BarberShopInfoAPI"];
            // Construindo a URL com o parâmetro de consulta
            var requestUrl = $"{barberShopApiUrl}/api/BarberShopInfo/GetByUserId?UserId={barberShop.Id}";

            // Adicione o token JWT no cabeçalho de autorização
            client.DefaultRequestHeaders.Authorization = new AuthenticationHeaderValue("Bearer", token);

            // Fazendo a chamada GET assíncrona
            var response = await client.GetAsync(requestUrl);

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
    }
}
