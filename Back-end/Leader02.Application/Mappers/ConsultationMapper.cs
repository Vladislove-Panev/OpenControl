using Leader.Domain.Entity;
using Leader02.Application.DtoModels;
using Riok.Mapperly.Abstractions;

namespace Leader02.Application.Mappers;

[Mapper]
public static partial class ConsultationMapper
{
    public static partial ConsultationDto ConsultationToConsultationDto(this Consultation consultationSlot);
    public static partial List<ConsultationDto> ConsultationsToConsultationsDto(this List<Consultation> consultationSlots);
}