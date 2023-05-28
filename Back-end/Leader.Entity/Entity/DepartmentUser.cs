namespace Leader.Domain.Entity;

public class DepartmentUser
{
    public long Id { get; set; }
    public string LastName { get; set; } = string.Empty;
    public string FirstName { get; set; } = string.Empty;
    public string? MiddleName { get; set; } = string.Empty;
    public string Email { get; set; } = string.Empty;
    public string? MobilePhone { get; set; }
    public string? StationaryPhone { get; set; }
    public string Password { get; set; } = string.Empty;

    public int? SubDepartmentId { get; set; }
    public SubDepartment? SubDepartment { get; set; }

    public List<Consultation>? Consultations { get; set; }
}