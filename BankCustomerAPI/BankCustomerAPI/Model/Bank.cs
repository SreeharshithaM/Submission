using System.ComponentModel.DataAnnotations;

namespace BankCustomerAPI.Model
{
    public class Bank
    {
        public int BankId { get; set; }
        public string? Name { get; set; }
        public ICollection<Branch> Branches { get; set; }
    }
}
