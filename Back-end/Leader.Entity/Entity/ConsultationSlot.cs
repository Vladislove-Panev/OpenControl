using Leader.Domain.Enums;

namespace Leader.Domain.Entity;

public class ConsultationSlot
{
    public Guid Id { get; set; }
    public DateTime SlotDate { get; set; }
    public string SlotTime { get; set; } = string.Empty;
    public ConsultationSlotStatus Status { get; set; }
    public string? OtherInformation { get; set; }
    
    public int? SubDepartmentId { get; set; }
    public SubDepartment? SubDepartment { get; set; }
}