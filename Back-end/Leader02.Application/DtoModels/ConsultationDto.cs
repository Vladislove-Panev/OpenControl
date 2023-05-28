namespace Leader02.Application.DtoModels;

public class ConsultationDto
{
    public Guid Id { get; set; }
    public string? Topic { get; set; }
    public DateTime? StarDateTime { get; set; }
    public DateTime? FinishDateTime { get; set; }
    public string? VideoRecordPath { get; set; }
    public string? OtherInformation { get; set; }

    public long UserId { get; set; }
    public long? DepartmentUserId { get; set; }
    public Guid ConsultationSlotId { get; set; }
}