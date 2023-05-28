namespace Leader02.Application.DtoModels;

public class DepartmentUserDto
{
    public long Id { get; set; }
    public string LastName { get; set; } = string.Empty;
    public string FirstName { get; set; } = string.Empty;
    public string? MiddleName { get; set; } = string.Empty;
    public string Email { get; set; } = string.Empty;
    public string? MobilePhone { get; set; }
    public string? StationaryPhone { get; set; }
    public SubDepartmentDto? SubDepartment { get; set; } = new();
}