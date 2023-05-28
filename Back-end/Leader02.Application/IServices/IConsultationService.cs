using Leader02.Application.DtoModels;

namespace Leader02.Application.IServices;

public interface IConsultationService
{
    Task<ConsultationDto?> CreateConsultation(string? topic, long userId, Guid consultationSlotId, CancellationToken ct);
}