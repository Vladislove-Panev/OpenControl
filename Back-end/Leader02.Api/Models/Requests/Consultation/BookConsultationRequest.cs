namespace Leader02.Api.Models.Requests.Consultation;

public class BookConsultationRequest
{
    public string? Topic { get; set; }
    public long UserId { get; set; }
    public Guid ConsultationSlotId { get; set; }
}