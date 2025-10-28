-- Create Schema if not exists
IF NOT EXISTS (SELECT * FROM sys.schemas WHERE name = 'BankingSystem')
BEGIN
    EXEC('CREATE SCHEMA BankingSystem');
END;
GO

-- Banks and Branches
CREATE TABLE BankingSystem.Banks (
    BankID INT PRIMARY KEY IDENTITY(1,1),
    BankName VARCHAR(100) NOT NULL,
    BankCode VARCHAR(10) NOT NULL UNIQUE
);

CREATE TABLE BankingSystem.Branches (
    BranchID INT PRIMARY KEY IDENTITY(1,1),
    BankID INT NOT NULL,
    BranchCode VARCHAR(10) NOT NULL,
    BranchName VARCHAR(100) NOT NULL,
    FOREIGN KEY (BankID) REFERENCES BankingSystem.Banks(BankID)
);

-- Users
CREATE TABLE BankingSystem.Users (
    UserID INT PRIMARY KEY IDENTITY(1,1),
    Username VARCHAR(50) NOT NULL UNIQUE,
    FullName VARCHAR(100),
    DateOfBirth DATE,
    Email VARCHAR(100),
    Phone VARCHAR(20),
    CreatedAt DATETIME DEFAULT GETDATE()
);

-- Roles and UserRoles (Many to Many)
CREATE TABLE BankingSystem.Roles (
    RoleID INT PRIMARY KEY IDENTITY(1,1),
    RoleName VARCHAR(50) NOT NULL UNIQUE,
    Description VARCHAR(255)
);

CREATE TABLE BankingSystem.UserRoles (
    UserID INT NOT NULL,
    RoleID INT NOT NULL,
    PRIMARY KEY (UserID, RoleID),
    FOREIGN KEY (UserID) REFERENCES BankingSystem.Users(UserID),
    FOREIGN KEY (RoleID) REFERENCES BankingSystem.Roles(RoleID)
);

-- Permissions and RolePermissions (Many to Many)
CREATE TABLE BankingSystem.Permissions (
    PermissionID INT PRIMARY KEY IDENTITY(1,1),
    PermissionName VARCHAR(50) NOT NULL UNIQUE,
    Description VARCHAR(255)
);

CREATE TABLE BankingSystem.RolePermissions (
    RoleID INT NOT NULL,
    PermissionID INT NOT NULL,
    PRIMARY KEY (RoleID, PermissionID),
    FOREIGN KEY (RoleID) REFERENCES BankingSystem.Roles(RoleID),
    FOREIGN KEY (PermissionID) REFERENCES BankingSystem.Permissions(PermissionID)
);

-- Accounts
CREATE TABLE BankingSystem.Accounts (
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
    FOREIGN KEY (UserID) REFERENCES BankingSystem.Users(UserID),
    FOREIGN KEY (BranchID) REFERENCES BankingSystem.Branches(BranchID)
);

-- Term Deposits
CREATE TABLE BankingSystem.TermDeposits (
    TermDepositID INT PRIMARY KEY IDENTITY(1,1),
    AccountID INT NOT NULL,
    StartDate DATE NOT NULL,
    MaturityDate DATE NOT NULL,
    InterestRate DECIMAL(5, 2) NOT NULL,
    FOREIGN KEY (AccountID) REFERENCES BankingSystem.Accounts(AccountID)
);

-- Account Operations Logs
CREATE TABLE BankingSystem.AccountOperations (
    OperationID INT PRIMARY KEY IDENTITY(1,1),
    AccountID INT NOT NULL,
    OperationType VARCHAR(50), -- Deposit, Withdraw, Close, CheckBalance, Operate
    Amount DECIMAL(18, 2),
    OperationDate DATETIME DEFAULT GETDATE(),
    PerformedByUserID INT,
    FOREIGN KEY (AccountID) REFERENCES BankingSystem.Accounts(AccountID),
    FOREIGN KEY (PerformedByUserID) REFERENCES BankingSystem.Users(UserID)
);
