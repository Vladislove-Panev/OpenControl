namespace Leader.Domain.Entity;

public class SubDepartmentTsVector
{
    public int Id { get; set; }
    public string Description { get; set; } = string.Empty;

    public SubDepartment SubDepartment { get; set; } = new();
}