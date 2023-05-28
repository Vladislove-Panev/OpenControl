using Leader.Domain.Entity;
using Leader.Domain.Interfaces;
using Microsoft.EntityFrameworkCore;

namespace Leader02.Infrastructure.Repositories;

public class RequirementRepository : BaseRepository<Requirement>, IRequirementRepository
{
    public RequirementRepository(Leader02Context dbContext) : base(dbContext)
    {
    }

    public async Task<Requirement?> GetById(long id, CancellationToken ct)
    {
        return await DbContext.Requirements
            .Where(x => x.Id == id)
            .Include(x => x.SubDepartment)
            .Include(x => x.Department)
            .FirstOrDefaultAsync(cancellationToken: ct);
    }

    public async Task<List<Requirement>> GetManyByIds(IEnumerable<long> ids, CancellationToken ct)
    {
        return await DbContext.Requirements
            .Where(p => ids.Contains(p.Id))
            .Include(x => x.SubDepartment)
            .Include(x => x.Department)
            .ToListAsync(cancellationToken: ct);
    }

    public Task<List<Requirement>> FindBySubDepartment(int id, CancellationToken ct)
    {
        throw new NotImplementedException();
    }

    public Task<List<Requirement>> FindByDepartment(int id, CancellationToken ct)
    {
        throw new NotImplementedException();
    }

    public Task<List<Requirement>> FindByBasicRequirementDescription(string basicRequirementDescription, CancellationToken ct)
    {
        throw new NotImplementedException();
    }

    public Task<List<Requirement>> FindByBasicRequirementDetail(string basicRequirementDetail, CancellationToken ct)
    {
        throw new NotImplementedException();
    }
}