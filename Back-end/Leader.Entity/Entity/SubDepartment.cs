namespace Leader.Domain.Entity;

public class SubDepartment
{
    public int Id { get; set; }
    public string Name { get; set; } = string.Empty;
    public string? SubDepartmentUrl { get; set; }
    public string? SubDepartmentDescription { get; set; }
    
    public SubDepartmentTsVector? SubDepartmentTsVector { get; set; }
    
    public int? DepartmentId { get; set; }
    public Department? Department { get; set; }
    
    public List<DepartmentUser>? DepartmentUsers { get; set; }
    public List<ConsultationSlot>? ConsultationSlots { get; set; }
    public List<ConsultationTopic>? ConsultationTopics { get; set; }
    public List<LegalAct>? LegalActs { get; set; }
    public List<Requirement>? Requirements { get; set; }
 }