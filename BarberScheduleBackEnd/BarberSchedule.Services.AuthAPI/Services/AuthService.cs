using Azure.Core;
using BarberSchedule.Services.AuthAPI.Data;
using BarberSchedule.Services.AuthAPI.Dto;
using BarberSchedule.Services.AuthAPI.Models;
using BarberSchedule.Services.AuthAPI.Services.Interface;
using Microsoft.AspNetCore.Identity;

namespace BarberSchedule.Services.AuthAPI.Services
{
    public class AuthService : IAuthService
    {
        private readonly AuthDbContext _context;
        private readonly UserManager<UserModel> _userManager;
        private readonly RoleManager<IdentityRole> _roleManager;
        private readonly IBarberShopInfoService _barberShopInfoService;

        public AuthService(
            AuthDbContext context, 
            UserManager<UserModel> userManager,
            RoleManager<IdentityRole> roleManager,
            IBarberShopInfoService barberShopInfoService)
        {
            _context = context;
            _userManager = userManager;
            _roleManager = roleManager;
            _barberShopInfoService = barberShopInfoService;
        }

        public async Task AsignRole(string roleName, UserModel user)
        {
            if (!_roleManager.RoleExistsAsync(roleName).Result)
            {
                _roleManager.CreateAsync(new IdentityRole(roleName)).GetAwaiter().GetResult();
            }
            await _userManager.AddToRoleAsync(user, roleName);
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

                    var barberShopInfo = new BarberShopInfoModel
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
