-- Banks
CREATE TABLE Banks (
    BankID INT PRIMARY KEY IDENTITY(1,1),
    BankName VARCHAR(100) NOT NULL,
    BankCode VARCHAR(10) NOT NULL UNIQUE
);

-- Branches
CREATE TABLE Branches (
    BranchID INT PRIMARY KEY IDENTITY(1,1),
    BankID INT NOT NULL,
    BranchCode VARCHAR(10) NOT NULL,
    BranchName VARCHAR(100) NOT NULL,
    FOREIGN KEY (BankID) REFERENCES Banks(BankID)
);

-- Users (Bank Customers)
CREATE TABLE Users (
    UserID INT PRIMARY KEY IDENTITY(1,1),
    Username VARCHAR(50) NOT NULL UNIQUE,
    FullName VARCHAR(100) NOT NULL,
    DateOfBirth DATE NULL,
    Email VARCHAR(100) NULL,
    Phone VARCHAR(20) NULL,
    PasswordHash VARCHAR(255) NOT NULL,
    CreatedAt DATETIME DEFAULT GETDATE(),
    ModifiedAt DATETIME NULL
);

-- Accounts
CREATE TABLE Accounts (
    AccountID INT PRIMARY KEY IDENTITY(1,1),
    UserID INT NOT NULL,
    BranchID INT NOT NULL,
    AccountNumber VARCHAR(20) NOT NULL UNIQUE,
    AccountType VARCHAR(20) NOT NULL CHECK (AccountType IN ('Saving', 'Current', 'TermDeposit')),
    CurrencyCode VARCHAR(3) NOT NULL,
    Balance DECIMAL(18,2) DEFAULT 0,
    IsMinorOperated BIT DEFAULT 0,
    IsPOAOperated BIT DEFAULT 0,
    CreatedAt DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (UserID) REFERENCES Users(UserID),
    FOREIGN KEY (BranchID) REFERENCES Branches(BranchID)
);

-- Term Deposits
CREATE TABLE TermDeposits (
    TermDepositID INT PRIMARY KEY IDENTITY(1,1),
    AccountID INT NOT NULL,
    StartDate DATE NOT NULL,
    MaturityDate DATE NOT NULL,
    InterestRate DECIMAL(5,2) NOT NULL,
    PrincipalAmount DECIMAL(18,2) NOT NULL DEFAULT 0,
    FOREIGN KEY (AccountID) REFERENCES Accounts(AccountID)
);

-- Roles 
CREATE TABLE Roles (
    RoleID INT PRIMARY KEY IDENTITY(1,1),
    RoleName VARCHAR(50) NOT NULL UNIQUE,
    Description VARCHAR(255)
);

-- Permissions
CREATE TABLE Permissions (
    PermissionID INT PRIMARY KEY IDENTITY(1,1),
    PermissionName VARCHAR(50) NOT NULL UNIQUE,
    Description VARCHAR(255)
);

-- UserRoles 
CREATE TABLE UserRoles (
    UserID INT NOT NULL,
    RoleID INT NOT NULL,
    PRIMARY KEY (UserID, RoleID),
    FOREIGN KEY (UserID) REFERENCES Users(UserID),
    FOREIGN KEY (RoleID) REFERENCES Roles(RoleID)
);

-- UserPermissions 
CREATE TABLE UserPermissions (
    UserID INT NOT NULL,
    PermissionID INT NOT NULL,
    PRIMARY KEY (UserID, PermissionID),
    FOREIGN KEY (UserID) REFERENCES Users(UserID),
    FOREIGN KEY (PermissionID) REFERENCES Permissions(PermissionID)
);
