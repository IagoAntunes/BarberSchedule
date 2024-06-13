using Azure.Messaging.ServiceBus;
using Newtonsoft.Json;
using System.Text;

namespace BarberSchedule.MessageBus
{
    public class MessageBus : IMessageBus
    {
        public string connectionString = "Endpoint=sb://barberschedule.servicebus.windows.net/;SharedAccessKeyName=RootManageSharedAccessKey;SharedAccessKey=rG0VsNhcG0ibOUUdj0Y9Ejudy1So+re98+ASbNKiM6U=";

        public async Task PublishMessage(object message, string topic_queue_name)
        {
            await using var client = new ServiceBusClient(connectionString);

            ServiceBusSender sender= sender = client.CreateSender(topic_queue_name);

            var jsonMessage = JsonConvert.SerializeObject(message);

            ServiceBusMessage busMessage = new ServiceBusMessage(Encoding.UTF8.GetBytes(jsonMessage))
            {
                CorrelationId = Guid.NewGuid().ToString()
            };

            await sender.SendMessageAsync(busMessage);
            await client.DisposeAsync();
        }
    }
}
