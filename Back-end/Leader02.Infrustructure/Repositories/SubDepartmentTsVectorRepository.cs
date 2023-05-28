using Leader.Domain.Entity;
using Leader.Domain.Interfaces;
using Microsoft.EntityFrameworkCore;

namespace Leader02.Infrastructure.Repositories;

public class SubDepartmentTsVectorRepository : BaseRepository<SubDepartmentTsVector>, ISubDepartmentTsVectorRepository
{
    public SubDepartmentTsVectorRepository(Leader02Context dbContext) : base(dbContext)
    {
    }

    public async Task<SubDepartmentTsVector?> FindByName(string name, CancellationToken ct)
    {
        var query = $"""            
            SELECT "Id", "Description"
            FROM "SubDepartmentTsVectors"
            WHERE "ts" @@ plainto_tsquery('{name}')
            ORDER BY ts_rank("ts", plainto_tsquery('{name}')) desc
            """;

        return await DbContext.SubDepartmentTsVectors
            .FromSqlRaw(query)
            .FirstOrDefaultAsync(ct);
    }

    public async Task<List<SubDepartmentTsVector>> FindManyByName(string name, CancellationToken ct)
    {
        var query = $"""            
            SELECT "Id", "Description"
            FROM "SubDepartmentTsVectors"
            WHERE "ts" @@ plainto_tsquery('{name}')
            ORDER BY ts_rank("ts", plainto_tsquery('{name}')) desc
            """;

        return await DbContext.SubDepartmentTsVectors
            .FromSqlRaw(query)
            .ToListAsync(ct);
    }
}