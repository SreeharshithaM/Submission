using System.Security.Principal;

namespace BankCustomerAPI.Model
{
    public class Branch
    {
        public int BranchId { get; set; }
        public string? BranchName { get; set; }
        public string? IFSCCode { get; set; }
        public string? Address { get; set; }
        public int BankId { get; set; }
        public Bank? Bank { get; set; }
        public ICollection<Account> Accounts { get; set; }
    }
}
