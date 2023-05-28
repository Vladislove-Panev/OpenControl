namespace Leader02.Application.DtoModels;

public class LegalActDto
{
    public int Id { get; set; }
    public string Name { get; set; } = string.Empty;
    public DepartmentDto? Department { get; set; }
    public SubDepartmentDto? SubDepartment { get; set; }
    public string LegalActType { get; set; } = string.Empty;
    public DateTime DocumentDate { get; set; }
    public DateTime PublishDate { get; set; }
    public string? LegalActUrl { get; set; }
}