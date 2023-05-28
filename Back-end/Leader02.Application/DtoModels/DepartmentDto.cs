namespace Leader02.Application.DtoModels;

public class DepartmentDto
{
    public int Id { get; set; }
    public string Name { get; set; } = string.Empty;
    public string Abbreviation { get; set; } = string.Empty;
    public string? DepartmentUrl { get; set; }
    public string? Description { get; set; }
}