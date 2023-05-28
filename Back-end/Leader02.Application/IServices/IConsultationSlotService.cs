using Leader.Domain.Enums;
using Leader02.Application.DtoModels;

namespace Leader02.Application.IServices;

public interface IConsultationSlotService
{
    Task<List<ConsultationSlotDto>> GetAllBySubDepartmentId(int subDepartmentId, CancellationToken ct);
    Task<ConsultationSlotDto?> UpdateState(Guid id, ConsultationSlotStatus status, CancellationToken ct);
}