using Azure.Core;
using BarberSchedule.Services.AuthAPI.Data;
using BarberSchedule.Services.AuthAPI.Dto;
using BarberSchedule.Services.AuthAPI.Dto.Requests;
using BarberSchedule.Services.AuthAPI.Models;
using BarberSchedule.Services.AuthAPI.Services.Interface;
using BarberSchedule.Services.BarberShop.Dto;
using Microsoft.AspNetCore.Identity;
using System.Text.RegularExpressions;

namespace BarberSchedule.Services.AuthAPI.Services
{
    public class AuthService : IAuthService
    {
        private readonly AuthDbContext _context;
        private readonly UserManager<UserModel> _userManager;
        private readonly RoleManager<IdentityRole> _roleManager;
        private readonly IBarberShopInfoService _barberShopInfoService;
        private readonly IJwtTokenService _jwtTokenService;

        public AuthService(
            AuthDbContext context, 
            UserManager<UserModel> userManager,
            RoleManager<IdentityRole> roleManager,
            IBarberShopInfoService barberShopInfoService,
            IJwtTokenService jwtTokenService)
        {
            _context = context;
            _userManager = userManager;
            _roleManager = roleManager;
            _barberShopInfoService = barberShopInfoService;
            _jwtTokenService = jwtTokenService;
        }

        public async Task AsignRole(string roleName, UserModel user)
        {
            if (!_roleManager.RoleExistsAsync(roleName).Result)
            {
                _roleManager.CreateAsync(new IdentityRole(roleName)).GetAwaiter().GetResult();
            }
            await _userManager.AddToRoleAsync(user, roleName);
        }

        public async Task<string> GetEmailByUser(string userId)
        {
            var user = _userManager.FindByIdAsync(userId).Result;
            if(user == null)
            {
                return "";
            }
            return user.Email;
        }

        public async Task<string> GetUserToken(UserModel userModel)
        {
            var token =  await _userManager.GetAuthenticationTokenAsync(userModel, "Bearer","JWT");
            if (string.IsNullOrEmpty(token))
            {
                token =  await _jwtTokenService.CreateToken(userModel);
                await _userManager.SetAuthenticationTokenAsync(userModel, "Bearer", "JWT", token);
            }
            return token;
        }

        public async Task<LoginBarberShopResponseDto> LoginBarberShop(LoginBarberShopRequestDto request)
        {
            var barberShop = _context.Users.FirstOrDefault(u => u.Email == request.Email);
            if(barberShop == null)
            {
                return new LoginBarberShopResponseDto();
            }

            var loggedd = await _userManager.CheckPasswordAsync(barberShop,request.Password);
            if(loggedd == false)
            {
                new LoginBarberShopResponseDto();
            }
            var token = await GetUserToken(barberShop);
            var barberShopInfo = await _barberShopInfoService.GetBarberShopInfo(barberShop, token);

            var barberShopDto = new BarberShopInfoDto()
            {
                Id = barberShopInfo.Id,
                UserId = barberShopInfo.UserId,
                Name = barberShopInfo.Name,
                Description = barberShopInfo.Description,
                PhoneNumber = barberShopInfo.PhoneNumber,
                State = barberShopInfo.State,
                City = barberShopInfo.City,
                Number = barberShopInfo.Number,
                Photo = barberShopInfo.Photo,
                AvailableTimes = barberShopInfo.AvailableTimes,
                PaymentMethods = barberShopInfo.PaymentMethods,
            };
            var response = new LoginBarberShopResponseDto()
            {
                BarberShop = barberShopDto,
                Token = token
            };

            return response;

        }

        public async Task<LoginResponseUserDto> LoginClient(LoginClientRequest request)
        {
            var user = _context.Users.FirstOrDefault(u => u.Email == request.Email);
            if(user == null)
            {
                return new LoginResponseUserDto();
            }
            var resultLogin = await _userManager.CheckPasswordAsync(user, request.Password);
            if (resultLogin == false)
            {
                return new LoginResponseUserDto();
            }
        var userDto = new UserDto()
            {
                Id = user.Id,
                Email = user.Email,
                Name = user.UserName,
                PhoneNumber = user.PhoneNumber,
                Photo = user.Photo,
            };
            var token = await _jwtTokenService.CreateToken(user);

            await _userManager.SetAuthenticationTokenAsync(user, "Bearer","JWT",token);

            var response = new LoginResponseUserDto()
            {
                User = userDto,
                Token = token,
            };

            return response;
        }

        public async Task<string> RegisterBarberShop(RegisterBarberShopRequestDTO request)
        {
            try
            {
                var user = new UserModel
                {
                    Email = request.Email,
                    UserName = request.Name,
                    PhoneNumber = request.PhoneNumber,
                    Photo = request.Photo,
                };

                var result = await _userManager.CreateAsync(user);

                if(result.Succeeded)
                {
                    var userToReturn = _context.Users.First(u => u.UserName == request.Name);

                    if(userToReturn != null)
                    {
                        await AsignRole(request.RoleName,userToReturn);
                    }

                    var barberShopInfo = new CreateBarberShopInfoDto
                    {
                        Name = request.Name,
                        UserId = userToReturn.Id,
                        Photo = request.Photo,
                        Description = request.Description,
                        PhoneNumber = request.PhoneNumber,
                        State = request.State,
                        City = request.City,
                        Number = request.Number,
                        AvailableTimes = request.AvailableTimes,
                        PaymentMethods = request.PaymentMethods,
                    };
                    var token = await GetUserToken(userToReturn);
                    await _barberShopInfoService.CreateBarberShop(barberShopInfo, token);
                    

                    return "";
                }
                else
                {
                    return result.Errors.FirstOrDefault().Description;
                }
            }catch(Exception ex)
            {

                return "";
            }
        }

        public async Task<string> RegisterClient(RegisterClientRequestDto request)
        {
            try
            {
                var user = new UserModel
                {
                    Email = request.Email,
                    UserName = request.Name,
                    PhoneNumber = request.PhoneNumber,
                    Photo = request.Photo,
                };

                var result = await _userManager.CreateAsync(user, request.Password);
                if (result.Succeeded)
                {
                    var userToReturn = _context.Users.First(u => u.UserName == request.Name);

                    if(userToReturn != null)
                    {
                        await AsignRole(request.RoleName,userToReturn);
                    }
                    if (!string.IsNullOrEmpty(request.Photo))
                    {
                        var b64 = "";
                        var dataPrefixPattern = @"^data:image\/[a-zA-Z]+;base64,";
                        b64 = Regex.Replace(request.Photo, dataPrefixPattern, string.Empty);
                        byte[] imageBytes = Convert.FromBase64String(b64);

                        string fileName = user.Id + user.UserName + ".png";
                        string filePath = @"wwwroot\UserImages\" + fileName;
                        // Caminho completo do arquivo
                        var filePathDirectory = Path.Combine(Directory.GetCurrentDirectory(), filePath);

                        // Salvar o arquivo
                        await System.IO.File.WriteAllBytesAsync(filePathDirectory, imageBytes);
                    }

                    UserDto userDto = new UserDto()
                    {
                        Id = userToReturn.Id,
                        Email = userToReturn.Email,
                        Name = userToReturn.UserName,
                        PhoneNumber = userToReturn.PhoneNumber,
                        Photo = userToReturn.Photo,
                    };

                    return "";
                }
                else
                {
                    return result.Errors.FirstOrDefault().Description;
                }

            }catch(Exception ex)
            {
                return "Erro Inesperado";
            }
        }
    }
}
