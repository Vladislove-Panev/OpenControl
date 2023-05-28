using Leader.Domain.Entity;
using Leader.Domain.Interfaces;
using Microsoft.EntityFrameworkCore;

namespace Leader02.Infrastructure.Repositories;

public class LegalActRepository : BaseRepository<LegalAct>, ILegalActRepository
{
    public LegalActRepository(Leader02Context dbContext) : base(dbContext)
    {
    }

    public async Task<LegalAct?> GetById(int id, CancellationToken ct)
    {
        return await DbContext.LegalActs.Where(x => x.Id == id)
            .Include(x => x.SubDepartment)
            .Include(x => x.Department)
            .FirstOrDefaultAsync(cancellationToken: ct);
    }

    public Task<List<LegalAct>> FindBySubDepartmentId(int id, CancellationToken ct)
    {
        throw new NotImplementedException();
    }

    public Task<List<LegalAct>> FindByDepartmentId(int id, CancellationToken ct)
    {
        throw new NotImplementedException();
    }

    public Task<List<LegalAct>> FindManyByName(string id, CancellationToken ct)
    {
        throw new NotImplementedException();
    }
}