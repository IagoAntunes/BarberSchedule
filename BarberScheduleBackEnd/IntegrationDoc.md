Pasta: Integration
Descrição:
Esta pasta contém implementações e integrações com serviços externos que a aplicação utiliza. Isso inclui serviços de mensageria, serviços de email e qualquer outro serviço externo necessário para o funcionamento da aplicação.

Componentes Principais:

BusService: Implementação do serviço de mensageria utilizando Azure Service Bus. Este componente é responsável por publicar e consumir mensagens de forma assíncrona, garantindo a comunicação desacoplada entre serviços.
EmailService: Implementação do serviço de envio de emails, utilizado para enviar notificações e confirmações para os clientes.
