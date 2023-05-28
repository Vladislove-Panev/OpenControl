using Leader.Domain.Entity;
using Leader.Domain.Interfaces;
using Microsoft.EntityFrameworkCore;

namespace Leader02.Infrastructure.Repositories;

public class ConsultationSlotRepository : BaseRepository<ConsultationSlot>, IConsultationSlotRepository
{
    public ConsultationSlotRepository(Leader02Context dbContext) : base(dbContext)
    {
    }

    public async Task<List<ConsultationSlot>> GetAllBySubDepartmentId(int subDepartmentId, CancellationToken ct)
    {
        return await DbContext.ConsultationSlots.Where(x => x.SubDepartmentId == subDepartmentId).ToListAsync(ct);
    }

    public async Task<ConsultationSlot?> GetById(Guid id, CancellationToken ct)
    {
        return await DbContext.ConsultationSlots.FirstOrDefaultAsync(x => x.Id == id, cancellationToken: ct);
    }
}