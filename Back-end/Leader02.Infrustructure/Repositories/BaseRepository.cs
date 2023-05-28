using Leader.Domain.Interfaces;
using Microsoft.EntityFrameworkCore;

namespace Leader02.Infrastructure.Repositories;

public class BaseRepository<T> : IBaseRepository<T> where T : class
{
    protected readonly Leader02Context DbContext;

    protected BaseRepository(Leader02Context dbContext)
    {
        DbContext = dbContext;
    }

    public async Task<List<T>> GetAll(CancellationToken ct)
    {
        return await DbContext.Set<T>().ToListAsync(ct);
    }

    public async Task<bool> AddAsync(T entity, CancellationToken ct)
    {
        await DbContext.Set<T>().AddAsync(entity, ct);
        var saved = await DbContext.SaveChangesAsync(ct);
        return saved > 0;
    }

    public async Task AddManyAsync(IEnumerable<T> entity, CancellationToken ct)
    {
        await DbContext.Set<T>().AddRangeAsync(entity, ct);
        await DbContext.SaveChangesAsync(ct);
    }

    public async Task<T> UpdateAsync(T entity, CancellationToken ct)
    {
        DbContext.Set<T>().Update(entity);
        await DbContext.SaveChangesAsync(ct);
        return entity;
    }

    public async Task RemoveAsync(T entity, CancellationToken ct)
    {
        DbContext.Set<T>().Remove(entity);
        await DbContext.SaveChangesAsync(ct);
    }
}