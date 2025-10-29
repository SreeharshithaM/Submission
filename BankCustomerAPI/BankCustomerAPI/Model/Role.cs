using System.ComponentModel.DataAnnotations;

namespace BankCustomerAPI.Model
{
    public class Role
    {
        public int RoleId { get; set; }
        public string? RoleName { get; set; }
        public ICollection<UserRole> UserRoles { get; set; }
        public ICollection<RolePermission> RolePermissions { get; set; }
    }
}
