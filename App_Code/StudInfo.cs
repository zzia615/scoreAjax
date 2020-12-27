using System.ComponentModel.DataAnnotations;
/// <summary>
/// 学生信息表
/// </summary>
public class StudInfo
{
    [Key]
    [StringLength(50)]
    public string StudNo { get; set; }
    [StringLength(50)]
    public string StudName { get; set; }
    [StringLength(50)]
    public string StudSex { get; set; }
    [StringLength(50)]
    public string Email { get; set; }
}
