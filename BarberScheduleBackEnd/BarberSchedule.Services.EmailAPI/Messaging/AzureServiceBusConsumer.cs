
using Azure.Messaging.ServiceBus;
using BarberSchedule.Services.EmailAPI.Dto;
using BarberSchedule.Services.EmailAPI.Service.Interfaces;
using Newtonsoft.Json;
using System.Text;

namespace BarberSchedule.Services.EmailAPI.Messaging
{
    public class AzureServiceBusConsumer : IAzureServiceBusConsumer
    {
        private readonly IConfiguration _configuration;
        private readonly string _serviceBusConnectionString;

        //Props do Email
        private readonly string emailCartQueue;
        private readonly IEmailService _emailService;
        private readonly ServiceBusProcessor _emailCartProcessor;
        public AzureServiceBusConsumer(
            IConfiguration configuration,
            IEmailService emailService)
        {
            _configuration = configuration;
            _serviceBusConnectionString = _configuration.GetValue<string>("ServiceBusConnectionString");


            _emailService = emailService;
            emailCartQueue = _configuration.GetValue<string>("TopicAndQueueNames:EmailOrderBarber");

            var client = new ServiceBusClient(_serviceBusConnectionString);
            _emailCartProcessor = client.CreateProcessor(emailCartQueue, new ServiceBusProcessorOptions());
        }

        public async Task Start()
        {
            _emailCartProcessor.ProcessMessageAsync += OnEmailCartRequestReceived;
            _emailCartProcessor.ProcessErrorAsync += ErrorHandler;

            await _emailCartProcessor.StartProcessingAsync();
        }

        private async Task ErrorHandler(ProcessErrorEventArgs args)
        {
            throw new NotImplementedException();
        }

        private async Task OnEmailCartRequestReceived(ProcessMessageEventArgs args)
        {
            var message = args.Message;
            var body = Encoding.UTF8.GetString(message.Body);

            OrderToEmailDto objMessage = JsonConvert.DeserializeObject<OrderToEmailDto>(body);
            try
            {
                await _emailService.EmailCartAndLog(objMessage);
                await args.CompleteMessageAsync(args.Message);
            }
            catch
            {
                throw;
            }
        }

        public async Task Stop()
        {
            await _emailCartProcessor.StopProcessingAsync();
            await _emailCartProcessor.DisposeAsync();
        }
    }
}
