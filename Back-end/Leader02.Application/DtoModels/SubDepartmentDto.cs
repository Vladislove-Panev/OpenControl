namespace Leader02.Application.DtoModels;

public class SubDepartmentDto
{
    public int Id { get; set; }
    public string Name { get; set; } = string.Empty;
    public string? SubDepartmentUrl { get; set; }
    public string? SubDepartmentDescription { get; set; }
    public DepartmentDto? Department { get; set; }
}