Estrutura do Projeto Backend
Pasta: Gateway
Descri��o:
Esta pasta cont�m a configura��o e implementa��o do API Gateway utilizando Ocelot. O Gateway atua como um ponto de entrada �nico para todas as requisi��es que v�m dos aplicativos cliente e barbearia. Ele roteia as requisi��es para os servi�os apropriados, gerencia a autentica��o e autoriza��o, e pode adicionar funcionalidades adicionais como rate limiting, caching e load balancing.

Componentes Principais:

Ocelot Configuration: Arquivos de configura��o do Ocelot para definir as rotas, pol�ticas de autentica��o, e outras configura��es de gateway.