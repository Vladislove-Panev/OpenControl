using Leader.Domain.Entity;

namespace Leader.Domain.Interfaces;

public interface IConsultationSlotRepository : IBaseRepository<ConsultationSlot>
{
    Task<List<ConsultationSlot>> GetAllBySubDepartmentId(int subDepartmentId, CancellationToken ct);
    Task<ConsultationSlot?> GetById(Guid id, CancellationToken ct);
}