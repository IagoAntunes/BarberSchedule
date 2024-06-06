Pasta: Integration
Descri��o:
Esta pasta cont�m implementa��es e integra��es com servi�os externos que a aplica��o utiliza. Isso inclui servi�os de mensageria, servi�os de email e qualquer outro servi�o externo necess�rio para o funcionamento da aplica��o.

Componentes Principais:

BusService: Implementa��o do servi�o de mensageria utilizando Azure Service Bus. Este componente � respons�vel por publicar e consumir mensagens de forma ass�ncrona, garantindo a comunica��o desacoplada entre servi�os.
EmailService: Implementa��o do servi�o de envio de emails, utilizado para enviar notifica��es e confirma��es para os clientes.
