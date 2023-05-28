using Leader.Domain.Entity;
using Leader02.Application.DtoModels;
using Riok.Mapperly.Abstractions;

namespace Leader02.Application.Mappers;

[Mapper]
public static partial class ConsultationSlotMapper
{
    public static partial ConsultationSlotDto ConsultationSlotToConsultationSlotDto(this ConsultationSlot consultationSlot);
    public static partial List<ConsultationSlotDto> ConsultationSlotsToConsultationSlotsDto(this List<ConsultationSlot> consultationSlots);
}