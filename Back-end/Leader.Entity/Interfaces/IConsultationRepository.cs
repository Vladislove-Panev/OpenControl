using Leader.Domain.Entity;

namespace Leader.Domain.Interfaces;

public interface IConsultationRepository : IBaseRepository<Consultation>
{
    Task<Consultation?> GetByConsultationSlotId(Guid id, CancellationToken ct);
}