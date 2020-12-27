
using System;
using System.Data.Entity;
using System.Linq;

public class SqlDbContext : DbContext
{
    //您的上下文已配置为从您的应用程序的配置文件(App.config 或 Web.config)
    //使用“Model”连接字符串。默认情况下，此连接字符串针对您的 LocalDb 实例上的
    //“.Model”数据库。
    // 
    //如果您想要针对其他数据库和/或数据库提供程序，请在应用程序配置文件中修改“Model”
    //连接字符串。
    public SqlDbContext()
        : base("name=defaultDb")
    {
        
        if (UserInfo.Count() <= 0)
        {
            UserInfo.Add(new UserInfo
            {
                UserID="admin",UserName="管理员",Password="123456",role="管理员"
            });
            SaveChanges();
        }
        
        if (StudInfo.Count() <= 0)
        {
            StudInfo.Add(new StudInfo
            {
                StudNo = "00001",
                StudName = "张文华",
                StudSex = "男",
                Email = "test@test.com"
            });
            SaveChanges();
        }
    }

    protected override void OnModelCreating(DbModelBuilder modelBuilder)
    {
        modelBuilder.Entity<StudInfo>().ToTable("StudInfo");
        modelBuilder.Entity<UserInfo>().ToTable("UserInfo");
        base.OnModelCreating(modelBuilder);
    }

    //为您要在模型中包含的每种实体类型都添加 DbSet。有关配置和使用 Code First  模型
    //的详细信息，请参阅 http://go.microsoft.com/fwlink/?LinkId=390109。
    /// <summary>
    /// 学生信息
    /// </summary>
    public virtual DbSet<StudInfo> StudInfo { get; set; }
    /// <summary>
    /// 用户信息
    /// </summary>
    public virtual DbSet<UserInfo> UserInfo { get; set; }
}
