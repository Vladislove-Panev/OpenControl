namespace Leader.Domain.Interfaces;

public interface IBaseRepository<T> where T : class
{
    Task<List<T>> GetAll(CancellationToken ct);
    Task<bool> AddAsync(T entity, CancellationToken ct);
    Task AddManyAsync(IEnumerable<T> entity, CancellationToken ct);
    Task<T> UpdateAsync(T entity, CancellationToken ct);
    Task RemoveAsync(T entity, CancellationToken ct);
}