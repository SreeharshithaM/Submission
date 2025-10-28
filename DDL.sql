-- Banks and Branches
CREATE TABLE Banks (
    BankID INT PRIMARY KEY IDENTITY(1,1),
    BankName VARCHAR(100) NOT NULL,
    BankCode VARCHAR(10) NOT NULL UNIQUE
);

CREATE TABLE Branches (
    BranchID INT PRIMARY KEY IDENTITY(1,1),
    BankID INT NOT NULL,
    BranchCode VARCHAR(10) NOT NULL,
    BranchName VARCHAR(100) NOT NULL,
    FOREIGN KEY (BankID) REFERENCES Banks(BankID)
);

-- Users
CREATE TABLE Users (
    UserID INT PRIMARY KEY IDENTITY(1,1),
    Username VARCHAR(50) NOT NULL UNIQUE,
    FullName VARCHAR(100),
    DateOfBirth DATE,
    Email VARCHAR(100),
    Phone VARCHAR(20),
    CreatedAt DATETIME DEFAULT GETDATE()
);

-- Roles and UserRoles (Many to Many)
CREATE TABLE Roles (
    RoleID INT PRIMARY KEY IDENTITY(1,1),
    RoleName VARCHAR(50) NOT NULL UNIQUE,
    Description VARCHAR(255)
);

CREATE TABLE UserRoles (
    UserID INT NOT NULL,
    RoleID INT NOT NULL,
    PRIMARY KEY (UserID, RoleID),
    FOREIGN KEY (UserID) REFERENCES Users(UserID),
    FOREIGN KEY (RoleID) REFERENCES Roles(RoleID)
);

-- Permissions and RolePermissions (Many to Many)
CREATE TABLE Permissions (
    PermissionID INT PRIMARY KEY IDENTITY(1,1),
    PermissionName VARCHAR(50) NOT NULL UNIQUE,
    Description VARCHAR(255)
);

CREATE TABLE RolePermissions (
    RoleID INT NOT NULL,
    PermissionID INT NOT NULL,
    PRIMARY KEY (RoleID, PermissionID),
    FOREIGN KEY (RoleID) REFERENCES Roles(RoleID),
    FOREIGN KEY (PermissionID) REFERENCES Permissions(PermissionID)
);

-- Accounts
CREATE TABLE Accounts (
    AccountID INT PRIMARY KEY IDENTITY(1,1),
    UserID INT NOT NULL,
    BranchID INT NOT NULL,
    AccountNumber VARCHAR(20) NOT NULL UNIQUE,
    AccountType VARCHAR(20) NOT NULL CHECK (AccountType IN ('Saving', 'Current', 'TermDeposit')),
    CurrencyCode VARCHAR(3) NOT NULL,
    Balance DECIMAL(18, 2) DEFAULT 0,
    IsMinorOperated BIT DEFAULT 0,
    IsPOAOperated BIT DEFAULT 0,
    CreatedAt DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (UserID) REFERENCES Users(UserID),
    FOREIGN KEY (BranchID) REFERENCES Branches(BranchID)
);

-- Term Deposits (If additional info needed)
CREATE TABLE TermDeposits (
    TermDepositID INT PRIMARY KEY IDENTITY(1,1),
    AccountID INT NOT NULL,
    StartDate DATE NOT NULL,
    MaturityDate DATE NOT NULL,
    InterestRate DECIMAL(5, 2) NOT NULL,
    FOREIGN KEY (AccountID) REFERENCES Accounts(AccountID)
);

-- Account Operations Logs (optional)
CREATE TABLE AccountOperations (
    OperationID INT PRIMARY KEY IDENTITY(1,1),
    AccountID INT NOT NULL,
    OperationType VARCHAR(50), -- Deposit, Withdraw, Close, CheckBalance, Operate
    Amount DECIMAL(18, 2),
    OperationDate DATETIME DEFAULT GETDATE(),
    PerformedByUserID INT,
    FOREIGN KEY (AccountID) REFERENCES Accounts(AccountID),
    FOREIGN KEY (PerformedByUserID) REFERENCES Users(UserID)
);
