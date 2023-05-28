using Leader.Domain.Entity;
using Leader.Domain.Interfaces;
using Microsoft.EntityFrameworkCore;

namespace Leader02.Infrastructure.Repositories;

public class LegalActTsVectorRepository : BaseRepository<LegalActTsVector>, ILegalActTsVectorRepository
{
    public LegalActTsVectorRepository(Leader02Context dbContext) : base(dbContext)
    {
    }

    public async Task<LegalActTsVector?> FindByName(string name, CancellationToken ct)
    {
        var query = $"""            
            SELECT "Id", "Name"
            FROM "LegalActTsVectors"
            WHERE "ts" @@ plainto_tsquery('{name}')
            ORDER BY ts_rank("ts", plainto_tsquery('{name}')) desc
            """;

        return await DbContext.LegalActTsVectors
            .FromSqlRaw(query)
            .FirstOrDefaultAsync(ct);
    }

    public async Task<List<LegalActTsVector>> FindManyByName(string name, CancellationToken ct)
    {
        var query = $"""            
            SELECT "Id", "Name"
            FROM "LegalActTsVectors"
            WHERE "ts" @@ plainto_tsquery('{name}')
            ORDER BY ts_rank("ts", plainto_tsquery('{name}')) desc
            """;

        return await DbContext.LegalActTsVectors
            .FromSqlRaw(query)
            .ToListAsync(ct);
    }
}