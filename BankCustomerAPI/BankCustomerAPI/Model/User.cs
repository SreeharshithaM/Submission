using System.ComponentModel.DataAnnotations;

namespace BankCustomerAPI.Model
{
    public class User
    {
        public int UserId { get; set; }
        public string? Username { get; set; }
        public string? Password { get; set; }
        public string? Email { get; set; }
        public string? PhoneNumber { get; set; }
        public DateTime CreatedDate { get; set; } = DateTime.UtcNow;
        public ICollection<Account> Accounts { get; set; }
        public ICollection<UserRole> UserRoles { get; set; }
    }
}
