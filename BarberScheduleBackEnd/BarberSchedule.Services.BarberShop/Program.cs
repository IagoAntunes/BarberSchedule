using AutoMapper;
using BarberSchedule.Services.AuthAPI;
using BarberSchedule.Services.AuthAPI.Data;
using BarberSchedule.Services.BarberShop.Service;
using BarberSchedule.Services.BarberShop.Service.Interfaces;
using Microsoft.EntityFrameworkCore;

var builder = WebApplication.CreateBuilder(args);

// Add services to the container.

builder.Services.AddControllers();
IMapper mapper = MappingConfig.RegisterMaps().CreateMapper();

builder.Services.AddSingleton(mapper);
builder.Services.AddScoped<IBarberShopInfoService,BarberShopInfoService>();
builder.Services.AddScoped<IPaymentMethodsService,PaymentMethodsService>();
var barberShopConnectionString = builder.Configuration.GetConnectionString("BarberShopInfoDefaultConnection");
builder.Services.AddDbContext<BarberShopInfoDbContext>(options =>
{
    options.UseSqlServer(barberShopConnectionString);
});
// Learn more about configuring Swagger/OpenAPI at https://aka.ms/aspnetcore/swashbuckle
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();

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
