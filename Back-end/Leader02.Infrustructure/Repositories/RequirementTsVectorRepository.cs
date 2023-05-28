using Leader.Domain.Entity;
using Leader.Domain.Interfaces;
using Microsoft.EntityFrameworkCore;

namespace Leader02.Infrastructure.Repositories;

public class RequirementTsVectorRepository : BaseRepository<RequirementTsVector>, IRequirementTsVectorRepository
{
    public RequirementTsVectorRepository(Leader02Context dbContext) : base(dbContext)
    {
    }

    public async Task<RequirementTsVector?> FindByBasicRequirement(string basicRequirementDetail, CancellationToken ct)
    {
        var query = $"""            
            SELECT "Id", "Number", "BasicRequirement"
            FROM "RequirementTsVectors"
            WHERE "ts" @@ plainto_tsquery('{basicRequirementDetail}')
            ORDER BY ts_rank("ts", plainto_tsquery('{basicRequirementDetail}')) desc
            """;

        return await DbContext.RequirementTsVectors
            .FromSqlRaw(query)
            .FirstOrDefaultAsync(ct);
    }

    public async Task<List<RequirementTsVector>> FindManyByBasicRequirement(string basicRequirementDetail, CancellationToken ct)
    {
        var query = $"""            
            SELECT "Id", "Number", "BasicRequirement"
            FROM "RequirementTsVectors"
            WHERE "ts" @@ plainto_tsquery('{basicRequirementDetail}')
            ORDER BY ts_rank("ts", plainto_tsquery('{basicRequirementDetail}')) desc
            """;

        return await DbContext.RequirementTsVectors
            .FromSqlRaw(query)
            .ToListAsync(ct);
    }
}