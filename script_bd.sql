-- Criação da tabela "PARKINGS"
CREATE TABLE PARKINGS (
    Id INT PRIMARY KEY IDENTITY(1,1),  -- Chave primária com incremento automático
    Name VARCHAR(150) NOT NULL,
    AvailableArea INT NOT NULL,
    Capacity INT NOT NULL,
    RegisterDate DATETIME DEFAULT GETDATE(),  -- Valor padrão com a data atual
    Street VARCHAR(100) NOT NULL,
    Complement VARCHAR(50),
    Neighborhood VARCHAR(100) NOT NULL,
    City VARCHAR(100) NOT NULL,
    State VARCHAR(50) NOT NULL,
    Cep VARCHAR(9) NOT NULL
);

-- Criação da tabela "ZONES"
CREATE TABLE ZONES (
    Id INT PRIMARY KEY IDENTITY(1,1),  -- Chave primária com incremento automático
    Name VARCHAR(100) NOT NULL,
    Description VARCHAR(500),
    Width INT NOT NULL,
    Length INT NOT NULL,
    ParkingId INT NOT NULL,  -- Chave estrangeira para "PARKINGS"
    FOREIGN KEY (ParkingId) REFERENCES PARKINGS(Id) ON DELETE CASCADE
);

-- Criação da tabela "GATEWAYS"
CREATE TABLE GATEWAYS (
    Id INT PRIMARY KEY IDENTITY(1,1),  -- Chave primária com incremento automático
    Model VARCHAR(100) NOT NULL,
    Status INT NOT NULL,
    MacAddress VARCHAR(17) NOT NULL,
    LastIP VARCHAR(15) NOT NULL,
    RegisterDate DATETIME DEFAULT GETDATE(),  -- Valor padrão com a data atual
    MaxCoverageArea INT NOT NULL,
    MaxCapacity INT NOT NULL,
    ParkingId INT NOT NULL,  -- Chave estrangeira para "PARKINGS"
    FOREIGN KEY (ParkingId) REFERENCES PARKINGS(Id) ON DELETE CASCADE
);
