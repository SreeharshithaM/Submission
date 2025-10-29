using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace BankCustomerAPI.Model
{
    public class Account
    {
        public int AccountId { get; set; }
        public string? AccountNumber { get; set; }
        public decimal Balance { get; set; }
        public DateTime CreatedDate { get; set; } = DateTime.UtcNow;
        public int BranchId { get; set; }
        public Branch? Branch { get; set; }
        public int UserId { get; set; }
        public User? User { get; set; }
    }
}
