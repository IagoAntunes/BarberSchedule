using BarberSchedule.Services.EmailAPI.Data;
using BarberSchedule.Services.EmailAPI.Messaging;
using BarberSchedule.Services.EmailAPI.Service;
using BarberSchedule.Services.EmailAPI.Service.Interfaces;
using Mango.Services.EmailAPI.Extension;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Options;
using System;

var builder = WebApplication.CreateBuilder(args);

var connectionString = builder.Configuration.GetConnectionString("DefaultConnection");
builder.Services.AddDbContext<EmailDbContext>(
    option => option.UseSqlServer(connectionString)
);

var optionBuilder = new DbContextOptionsBuilder<EmailDbContext>();
optionBuilder.UseSqlServer(connectionString);

builder.Services.AddSingleton<IEmailService>(new EmailService(optionBuilder.Options));

builder.Services.AddSingleton<IAzureServiceBusConsumer, AzureServiceBusConsumer>();

builder.Services.AddControllers();
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
app.UseAzureServiceBusConsumer();
app.Run();
