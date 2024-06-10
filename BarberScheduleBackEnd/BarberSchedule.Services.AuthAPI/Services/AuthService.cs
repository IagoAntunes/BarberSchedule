using Azure.Core;
using BarberSchedule.Services.AuthAPI.Data;
using BarberSchedule.Services.AuthAPI.Dto;
using BarberSchedule.Services.AuthAPI.Models;
using BarberSchedule.Services.AuthAPI.Services.Interface;
using BarberSchedule.Services.BarberShop.Dto;
using Microsoft.AspNetCore.Identity;

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

            var barberShopInfo = await _barberShopInfoService.GetBarberShopInfo(barberShop);

            var barberShopDto = new BarberShopInfoDto()
            {
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
            var token = await _jwtTokenService.CreateToken(barberShop);
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
            //TODO JWT GENERATOR

            var userDto = new UserDto()
            {
                Id = user.Id,
                Email = user.Email,
                Name = user.UserName,
                PhoneNumber = user.PhoneNumber,
                Photo = user.Photo,
            };
            var token = await _jwtTokenService.CreateToken(user);
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

                    await _barberShopInfoService.CreateBarberShop(barberShopInfo);
                    

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
