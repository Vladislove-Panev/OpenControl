using Leader.Domain.Entity;

namespace Leader.Domain.Interfaces;

public interface ILegalActRepository : IBaseRepository<LegalAct>
{
    Task<LegalAct?> GetById(int id, CancellationToken ct);
    Task<List<LegalAct>> FindBySubDepartmentId(int id, CancellationToken ct);
    Task<List<LegalAct>> FindByDepartmentId(int id, CancellationToken ct);
    Task<List<LegalAct>> FindManyByName(string id, CancellationToken ct);
}