# Pulse Registration System 🚀

## Descrição da aplicação

A aplicação **PulseSystem** foi desenvolvida para otimizar a gestão de estacionamentos, utilizando dispositivos de monitoramento de **Gateways** e a organização das vagas em diferentes **Zones** dentro de um estacionamento.

A solução é composta pelas seguintes entidades principais:

### 1. **Parking (Estacionamento)** 🏢

A classe **Parking** representa o conceito de um estacionamento físico, com informações essenciais como nome, área disponível, capacidade e a localização do estacionamento (endereço completo).

#### Atributos:
- **Name**: Nome do estacionamento.
- **AvailableArea**: Área disponível para estacionamentos.
- **Capacity**: Capacidade total de veículos que o estacionamento pode acomodar.
- **Location**: Localização física do estacionamento, incluindo rua, bairro, cidade, estado e CEP.

### 2. **Gateways (Dispositivos de Monitoramento)** 🎯

A classe **Gateway** representa dispositivos responsáveis pelo monitoramento das entradas e saídas dos veículos em cada estacionamento. Esses dispositivos são essenciais para o rastreamento de vagas e para garantir a automação no controle de acesso.

#### Atributos:
- **Model**: Modelo do dispositivo gateway.
- **Status**: Status do dispositivo (ativo, inativo, etc.).
- **MacAddress**: Endereço MAC do dispositivo.
- **LastIP**: O último IP registrado do gateway.
- **MaxCoverageArea**: A área máxima de cobertura do dispositivo.
- **MaxCapacity**: A capacidade máxima de veículos que o gateway pode monitorar simultaneamente.

### 3. **Zones (Zonas de Estacionamento)** 🅾️

A classe **Zone** define as áreas dentro do estacionamento, possibilitando uma organização mais detalhada e específica das vagas. Cada zona pode ter características e capacidades distintas, adequando-se às necessidades do estacionamento.

#### Atributos:
- **Name**: Nome da zona (ex: Zona A, Zona B, etc.).
- **Description**: Descrição da zona (opcional).
- **Width**: Largura da zona.
- **Length**: Comprimento da zona.

---

## Benefícios Gerais da Aplicação para o Negócio 🚀

- **Automação do Gerenciamento de Vagas**: A aplicação permite que o processo de controle de vagas e dispositivos seja totalmente automatizado, reduzindo a necessidade de monitoramento manual.
  
- **Escalabilidade e Flexibilidade**: A estrutura de **Gateways** e **Zones** permite que o sistema seja facilmente escalado conforme o crescimento do estacionamento, podendo adicionar mais dispositivos e áreas conforme a demanda.

- **Eficiência Operacional**: A gestão detalhada das **Zones** e a monitoração das **Gateways** permitem que a operação do estacionamento seja mais eficiente, evitando problemas de lotação e oferecendo uma experiência melhor para os usuários.

- **Análise de Dados em Tempo Real**: A integração com dispositivos e a coleta de dados em tempo real possibilitam análises detalhadas sobre a utilização do estacionamento, o que pode gerar insights para otimização de espaço e melhoria na distribuição de vagas.

Com essas entidades e funcionalidades, o **PulseSystem** oferece uma solução robusta e moderna para a gestão de estacionamentos, aproveitando a flexibilidade e os recursos do **Azure** e **.NET** para garantir uma operação mais eficiente e automatizada.

---

## Desenho da Arquitetura DevOps da Aplicação

<img width="1938" height="552" alt="Arquitetura da Solução Parking Registration drawio" src="https://github.com/user-attachments/assets/2664a095-7ed0-489d-85d4-33842e6094c2" />


## Configuração do Banco **Azure SQL Server** na Aplicação 🏗️

Para configurar a conexão com o **Azure SQL Server** na aplicação **Parking Registration**, siga os passos abaixo:

### 1. **Criar o Banco de Dados no Azure** 🌐

- Acesse o portal **Azure** e crie uma instância do **Azure SQL Database**.
- Ao criar o banco de dados, **anote** o **nome do servidor**, **nome do banco de dados**, e as **credenciais de acesso** (usuário e senha).

### 2. **Instalar a Dependência do SQL Server** 📦

Dentro da camada de **Infraestructure**, instale a dependência para conectar ao **SQL Server**:

#### Usando o Console do Gerenciador de Pacotes no Visual Studio:
```bash
Install-Package Microsoft.EntityFrameworkCore.SqlServer
```
#### Ou usando o .NET CLI:
```bash
dotnet add package Microsoft.EntityFrameworkCore.SqlServer
```

### 3. Configuração da Conexão na Aplicação 🔑
No arquivo appsettings.json, insira a string de conexão para o Azure SQL Server:
```bash
{
  "ConnectionStrings": {
    "DefaultConnection": "Server=tcp:<your-server-name>.database.windows.net,1433;Initial Catalog=<your-database-name>;Persist Security Info=False;User ID=<your-user-id>;Password=<your-password>;MultipleActiveResultSets=False;Encrypt=True;TrustServerCertificate=False;Connection Timeout=30;"
  }
}
```

### 4. Alteração do Método de Conexão 🔄
Como a aplicação originalmente usa Oracle, o método configurado é o UseOracle. Para o funcionamento correto com o Azure SQL Database, altere o método para UseSqlServer 
na classe CollectionExtensions:
```bash
options.UseSqlServer(configuration.GetConnectionString("SystemPulse"));
```

## Criação do Banco de Dados 💾
A aplicação pode ser configurada para criar o banco de dados de duas maneiras: utilizando Migrations do Entity Framework Core ou aplicando diretamente o script SQL presente no repositório. Abaixo estão as instruções detalhadas 
para ambas as opções:

### 1. Usando Migrations do Entity Framework Core 🛠️
Este projeto foi configurado para utilizar Migrations do Entity Framework Core para gerenciar a criação e atualização do banco de dados. Para criar o banco de dados utilizando as migrations, 
siga os passos abaixo:

#### Alterações Necessárias para Azure SQL Server:
O projeto foi originalmente configurado para usar Oracle e alguns tipos de dados precisam ser ajustados para garantir compatibilidade com o Azure SQL Database. 
Abaixo estão os ajustes principais:

**Tipos de dados:**
- VARCHAR2 no Oracle foi alterado para VARCHAR no SQL Server.
- NUMBER no Oracle foi alterado para INT no SQL Server.

**Funções de data:**
- SYSDATE foi alterado para GETDATE() para a compatibilidade com o SQL Server.

Essas alterações são necessárias nas classes de mapping (por exemplo, GatewayMapping, ParkingMapping, ZoneMapping) para garantir que o código gerado pela migration funcione corretamente no Azure SQL Server.

##### Passo 1: Gerar a Migration 🎲
Primeiramente, gere a migration que irá criar todas as tabelas no Azure SQL Database. Para isso, execute o seguinte comando:

No Console do Gerenciador de Pacotes do Visual Studio:
```bash
Add-Migration InitialCreate
```

Ou, utilizando o CLI do .NET:
```bash
dotnet ef migrations add InitialCreate
```

##### Passo 2: Aplicar a Migration ao Banco de Dados 🏦
Após a geração da migration, execute o comando abaixo para aplicar a migration e criar as tabelas no banco de dados:

No Console do Gerenciador de Pacotes:
```bash
Update-Database
```
Ou, utilizando o CLI do .NET:
```bash
dotnet ef database update
```

Esse comando irá executar a migration no banco de dados configurado, criando as tabelas e relacionamentos de acordo com as entidades definidas no projeto.

### 2. Usando o Script SQL (script_bd.sql) 📄
Se você preferir não usar Migrations, pode criar o banco de dados manualmente utilizando o script SQL presente no repositório. O arquivo script_bd.sql contém todas as instruções necessárias para criar o banco de dados, incluindo as tabelas e seus relacionamentos.

##### Passo 1: Localize o Arquivo script_bd.sql 📂
O arquivo script_bd.sql pode ser encontrado na raiz do repositório.

##### Passo 2: Executar o Script no Banco de Dados ⚙️
1. Conecte-se ao seu banco de dados Azure SQL Database, pode ser no Query Editor da Azure
2. Execute o conteúdo do script_bd.sql no banco de dados, e ele irá criar todas as tabelas e relacionamentos conforme o modelo do projeto.

---

---

## Casos de Teste 🧪

### Scripts de Testes efetuados



#### **Cadastrando um Parking: (POST)**:
```json
{
  "name": "Pátio Pinheiros",
  "location": {
    "street": "Rua Alfredo Neves",
    "complement": "54",
    "neighborhood": "Pinheiros",
    "cep": "02563256",
    "city": "São Paulo",
    "state": "SP"
  },
  "availableArea": 50000,
  "capacity": 500
}
```

### **Atualizando um Parking: (PUT)**:
```json
{
  
      "name": "Pátio Pinheiros",
      "location": {
        "street": "Rua Alfredo Neves",
        "complement": "555",
        "neighborhood": "Pinheiros",
        "cep": "02563256",
        "city": "São Paulo",
        "state": "SP"
      },
      "availableArea": 50000,
      "capacity": 450
}
```

#### **Cadastrando um Gateway: (POST)**:
```json
{
  "model": "Modelo 21XX",
  "status": 1,
  "macAddress": "A1:B2:C3:D4:E5:F6",
  "lastIP": "192.168.0.101",
  "parkingId": 1
}
```

#### **Cadastrando uma Zone: (POST)**:
```json
{
  "name": "Zona Mottu E",
  "description": "Alocação de motos modelo Mottu E",
  "width": 70,
  "length": 60,
  "parkingId": 1
}
```
---

### 👥 Grupo Desenvolvedor

- Gabriela Sousa Reis RM558830
- Laura Amadeu Soares RM556690
- Raphael Kim RM557914

