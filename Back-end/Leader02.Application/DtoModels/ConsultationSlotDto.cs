using Leader.Domain.Enums;

namespace Leader02.Application.DtoModels;

public class ConsultationSlotDto
{
    public Guid Id { get; set; }
    public DateTime SlotDate { get; set; }
    public string SlotTime { get; set; } = string.Empty;
    public ConsultationSlotStatus Status { get; set; }
}