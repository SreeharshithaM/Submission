using System.ComponentModel.DataAnnotations;

namespace BankCustomerAPI.Model
{
    public class Permission
    {
        public int PermissionId { get; set; }
        public string? PermissionName { get; set; }
        public string? Description { get; set; }
        public ICollection<RolePermission> RolePermissions { get; set; }
    }
}
