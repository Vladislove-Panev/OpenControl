namespace Leader02.Api.Models.Requests.ConsultationSlot;

public class GetSlotsRequest
{
    public DateTime? SlotDate { get; set; }
    public int? SubDepartmentId { get; set; }
}