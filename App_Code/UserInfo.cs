using System.ComponentModel.DataAnnotations;
/// <summary>
/// 用户信息表
/// </summary>
public class UserInfo
{
    [Key]
    [StringLength(50)]
    public string UserID { get; set; }
    [StringLength(50)]
    public string UserName { get; set; }
    [StringLength(50)]
    public string Password { get; set; }
    [StringLength(50)]
    public string role { get; set; }
}