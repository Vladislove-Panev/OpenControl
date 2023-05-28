using Leader.Domain.Entity;

namespace Leader.Domain.Interfaces;

public interface ILegalActTsVectorRepository : IBaseRepository<LegalActTsVector>
{
    Task<LegalActTsVector?> FindByName(string name, CancellationToken ct);
    Task<List<LegalActTsVector>> FindManyByName(string name, CancellationToken ct);
}