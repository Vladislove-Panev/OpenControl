using Leader02.Application.DtoModels;

namespace Leader02.Api.Models.Response.ConsultationSlot;

public class GetSlotsResponse
{
    public List<ConsultationSlotDto> ConsultationSlots { get; set; } = new();
}