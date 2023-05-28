namespace Leader.Domain.Entity;

public class LegalAct
{
    public int Id { get; set; }
    public string Name { get; set; } = string.Empty;
    public string LegalActType { get; set; } = string.Empty;
    public DateTime DocumentDate { get; set; }
    public DateTime PublishDate { get; set; }
    public string? LegalActUrl { get; set; }

    
    public LegalActTsVector? LegalActTsVectorName { get; set; }
    
    public int? DepartmentId { get; set; }
    public Department? Department { get; set; }
    
    public int? SubDepartmentId { get; set; }
    public SubDepartment? SubDepartment { get; set; }
}