Estrutura do Projeto Backend
Pasta: Gateway
Descrição:
Esta pasta contém a configuração e implementação do API Gateway utilizando Ocelot. O Gateway atua como um ponto de entrada único para todas as requisições que vêm dos aplicativos cliente e barbearia. Ele roteia as requisições para os serviços apropriados, gerencia a autenticação e autorização, e pode adicionar funcionalidades adicionais como rate limiting, caching e load balancing.

Componentes Principais:

Ocelot Configuration: Arquivos de configuração do Ocelot para definir as rotas, políticas de autenticação, e outras configurações de gateway.