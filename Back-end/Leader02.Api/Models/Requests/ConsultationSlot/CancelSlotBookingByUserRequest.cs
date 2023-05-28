namespace Leader02.Api.Models.Requests.ConsultationSlot;

public class CancelSlotBookingByUserRequest
{
    public Guid SlotId { get; set; }
    public long UserId { get; set; }
}