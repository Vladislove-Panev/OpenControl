using Leader.Domain.Entity;
using Leader.Domain.Interfaces;
using Microsoft.EntityFrameworkCore;

namespace Leader02.Infrastructure.Repositories;

public class ConsultationTopicRepository : BaseRepository<ConsultationTopic>, IConsultationTopicRepository
{
    public ConsultationTopicRepository(Leader02Context dbContext) : base(dbContext)
    {
    }

    public async Task<List<ConsultationTopic>> GetBySubDepartmentId(int subDepartmentId, CancellationToken ct)
    {
        return await DbContext.ConsultationTopics.Where(x => x.SubDepartmentId == subDepartmentId).ToListAsync(ct);
    }
}