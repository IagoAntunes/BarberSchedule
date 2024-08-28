![Barber Schedule Cover](https://github.com/user-attachments/assets/9efb8f7c-dc7a-4006-8867-7caf35be3007)

# :barber: BarberSchedule

**BarberSchedule** é uma plataforma que conecta clientes a barbearias, facilitando o agendamento de horários de maneira prática e eficiente. O aplicativo permite que os usuários visualizem os horários disponíveis, reservem serviços com seus barbeiros favoritos e recebam notificações sobre suas reservas.

- **Vídeo:** [Em Breve]

## :iphone: FrontEnd (Aplicativo)
- Flutter
- Micro-FrontEnd
- Arquitetura Limpa
<details>
<summary>Clique para Expandir!</summary>

## Introdução

Bem-vindo ao BarberSchedule! Este projeto foi desenvolvido para fornecer uma plataforma amigável onde os clientes podem facilmente agendar horários em sua barbearia preferida. O aplicativo permite que os usuários:

- Cadastrem-se e façam login para acessar todas as funcionalidades.
- Visualizem os horários disponíveis e reservem seus serviços preferidos.
- Consultem o histórico de agendamentos e gerenciem suas reservas.

### Projetos

- **client_app:** Este projeto é responsável pelo front-end voltado para os clientes, onde eles podem se cadastrar, visualizar os horários disponíveis e agendar serviços.
- **barbershop_app:** Este projeto é voltado para os barbeiros e administradores das barbearias, permitindo que eles gerenciem seus horários, visualizem reservas e interajam com os clientes.
- **design_system:** Este é um pacote compartilhado entre os dois projetos anteriores. Ele fornece estilos, componentes e padrões visuais para garantir uma experiência consistente em ambas as aplicações.

### Uso do Design System

Tanto o `client_app` quanto o `barbershop_app` utilizam o `design_system` como dependência para garantir que os estilos de cores, componentes e outros elementos visuais sejam consistentes em toda a plataforma. O design system foi desenvolvido como um package Flutter, facilitando a integração e o uso de seus recursos nos diferentes micro front-ends.

## Instalação

Para instalar este projeto, siga os seguintes passos:

1. Clone o repositório:
    ```sh
    git clone https://github.com/SeuUsuario/BarberScheduleApp.git
    ```
2. Instale as dependências:
    ```sh
    flutter pub get
    ```
3. Execute:
    ```sh
    flutter run
    ```

## :wrench: Tecnologias e Ferramentas

### Tecnologias
- Flutter

### Ferramentas
- [flutter_bloc](https://pub.dev/packages/flutter_bloc) - Utilizado para gerenciamento de estado.
- [dio](https://pub.dev/packages/dio) - Package utilizado para realizar consultas HTTP.
- [get_it](https://pub.dev/packages/get_it) - Package utilizado para realizar injeção de dependência.
- [shared_preferences](https://pub.dev/packages/shared_preferences) - Utilizado para armazenar dados do usuário localmente.

## Arquitetura
  
Este projeto segue a **Clean Architecture** para garantir a escalabilidade e facilidade de manutenção do código. A estrutura de pastas está organizada da seguinte forma:

### Estrutura de Pastas
lib │ ├── core │ ├── services │ ├── features │
- **core:** Contém configurações globais e constantes do aplicativo.
- **services:** Implementa os serviços como API, banco de dados e notificações.
- **features:** Contém as funcionalidades principais do aplicativo, como agendamento e gerenciamento de usuários.


- **domain:** Define as entidades e os contratos dos repositórios.
- **data:** Implementa os repositórios e fontes de dados.
- **presentation:** Contém as telas e lógica de apresentação.

</details>

## :computer: BackEnd
- ASP.NET Core
- Mensageria: Azure BusService
- Arquitetura Limpa
<details>
<summary>Clique para Expandir!</summary>

## Introdução

Bem-vindo ao BarberSchedule Backend! Este projeto foi desenvolvido utilizando ASP.NET Core para fornecer uma API robusta e segura que suporta as funcionalidades do aplicativo BarberSchedule.

Com esta API, você pode:

- Gerenciar autenticação e autorização de usuários.
- Criar, editar e deletar horários de agendamento.
- Utilização de BusService para mensageria.
- Armazenar e recuperar dados de clientes e agendamentos de forma eficiente.

### Mensageria com Azure Bus Service

Para garantir a comunicação eficiente entre os diferentes serviços da plataforma, foi implementada uma solução de mensageria utilizando o **Azure Bus Service**. Essa abordagem permite o envio e recebimento de mensagens assíncronas entre os componentes, facilitando a escalabilidade e a integração dos micro front-ends com o back-end.

## Instalação

Para instalar este projeto, siga os seguintes passos:

1. Clone o repositório:
    ```sh
    git clone https://github.com/SeuUsuario/BarberScheduleAPI.git
    ```
2. Navegue até o diretório do projeto:
    ```sh
    cd BarberScheduleAPI
    ```
3. Instale as dependências:
    ```sh
    dotnet restore
    ```
4. Execute a aplicação:
    ```sh
    dotnet run
    ```

## :wrench: Tecnologias e Ferramentas

### Tecnologias
- ASP.NET Core

### Dependências
- [Microsoft.AspNetCore.Authentication.JwtBearer](https://www.nuget.org/packages/Microsoft.AspNetCore.Authentication.JwtBearer) - Para autenticação JWT.
- [EntityFrameworkCore](https://www.nuget.org/packages/Microsoft.EntityFrameworkCore) - ORM para gerenciamento de banco de dados.
- [FluentValidation](https://www.nuget.org/packages/FluentValidation) - Para validação de dados de entrada.
- [Serilog](https://www.nuget.org/packages/Serilog) - Para logging.
- [AutoMapper](https://www.nuget.org/packages/AutoMapper) - Para mapeamento de objetos.

</details>
