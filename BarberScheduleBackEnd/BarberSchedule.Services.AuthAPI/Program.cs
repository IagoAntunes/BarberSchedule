using BarberSchedule.Services.AuthAPI.Data;
using BarberSchedule.Services.AuthAPI.Models;
using BarberSchedule.Services.AuthAPI.Services;
using BarberSchedule.Services.AuthAPI.Services.Interface;
using Microsoft.AspNetCore.Identity;
using Microsoft.EntityFrameworkCore;

var builder = WebApplication.CreateBuilder(args);
var authConnectionString = builder.Configuration.GetConnectionString("AuthDefaultConnection");

// Add services to the container.
builder.Services.AddHttpClient("BarberShopInfo", u => u.BaseAddress = 
new Uri(builder.Configuration["ServiceUrls:BarberShopInfoAPI"]));
builder.Services.AddControllers();
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();

//IMapper mapper = MappingConfig.RegisterMaps().CreateMapper();
//builder.Services.AddSingleton(mapper);

builder.Services.AddDbContext<AuthDbContext>(options =>
{
    options.UseSqlServer(authConnectionString);
});
builder.Services.AddScoped<IBarberShopInfoService, BarberShopInfoService>();
builder.Services.AddIdentity<UserModel, IdentityRole>()
    .AddEntityFrameworkStores<AuthDbContext>()
    .AddDefaultTokenProviders();
builder.Services.AddScoped<IAuthService, AuthService>();
var app = builder.Build();

// Configure the HTTP request pipeline.
if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}

app.UseHttpsRedirection();

app.UseAuthorization();

app.MapControllers();

app.Run();
