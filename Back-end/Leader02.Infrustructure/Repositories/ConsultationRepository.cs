using Leader.Domain.Entity;
using Leader.Domain.Interfaces;
using Microsoft.EntityFrameworkCore;

namespace Leader02.Infrastructure.Repositories;

public class ConsultationRepository : BaseRepository<Consultation>, IConsultationRepository
{
    public ConsultationRepository(Leader02Context dbContext) : base(dbContext)
    {
    }

    public async Task<Consultation?> GetByConsultationSlotId(Guid id, CancellationToken ct)
    {
        return await DbContext.Consultations.FirstOrDefaultAsync(x => x.ConsultationSlotId == id, cancellationToken: ct);
    }
}