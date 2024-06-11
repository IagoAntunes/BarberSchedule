using AutoMapper;
using BarberSchedule.Services.AuthAPI;
using BarberSchedule.Services.AuthAPI.Data;
using BarberSchedule.Services.AuthAPI.Models;
using BarberSchedule.Services.AuthAPI.Services;
using BarberSchedule.Services.AuthAPI.Services.Interface;
using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.AspNetCore.Identity;
using Microsoft.EntityFrameworkCore;
using Microsoft.IdentityModel.Tokens;
using System.Text;

var builder = WebApplication.CreateBuilder(args);
var authConnectionString = builder.Configuration.GetConnectionString("AuthDefaultConnection");

// Add services to the container.
builder.Services.AddHttpClient("BarberShopInfo", u => u.BaseAddress = 
new Uri(builder.Configuration["ServiceUrls:BarberShopInfoAPI"]));
builder.Services.AddControllers();
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();

builder.Services.Configure<JwtOptionsModel>(builder.Configuration.GetSection("JwtOptions"));

builder.Services.AddAuthentication(JwtBearerDefaults.AuthenticationScheme)
    .AddJwtBearer(options => options.TokenValidationParameters = new Microsoft.IdentityModel.Tokens.TokenValidationParameters
        {
        ValidateIssuer = true,
        ValidateAudience = true,
        ValidateLifetime = true,
        ValidateIssuerSigningKey = true,
        ValidIssuer = builder.Configuration["JwtOptions:Issuer"],
        ValidAudience = builder.Configuration["JwtOptions:Audience"],
        IssuerSigningKey = new SymmetricSecurityKey(Encoding.UTF8.GetBytes(builder.Configuration["JwtOptions:Secret"]))
        }
    );

builder.Services.Configure<IdentityOptions>(options =>
{
    options.Password.RequireDigit = false;
    options.Password.RequireLowercase = false;
    options.Password.RequireNonAlphanumeric = false;
    options.Password.RequireUppercase = false;
    options.Password.RequiredLength = 6;
});

builder.Services.AddIdentity<UserModel, IdentityRole>()
    .AddEntityFrameworkStores<AuthDbContext>()
    .AddRoles<IdentityRole>()
    .AddDefaultTokenProviders();


IMapper mapper = MappingConfig.RegisterMaps().CreateMapper();
builder.Services.AddSingleton(mapper);

builder.Services.AddDbContext<AuthDbContext>(options =>
{
    options.UseSqlServer(authConnectionString);
});
builder.Services.AddScoped<IBarberShopInfoService, BarberShopInfoService>();
builder.Services.AddScoped<IJwtTokenService,JwtTokenService>();
builder.Services.AddScoped<IAuthService, AuthService>();
var app = builder.Build();

// Configure the HTTP request pipeline.
if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}

app.UseHttpsRedirection();
app.UseAuthentication();
app.UseAuthorization();

app.MapControllers();

app.Run();
