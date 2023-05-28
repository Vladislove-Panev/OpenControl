using Leader.Domain.Entity;

namespace Leader.Domain.Interfaces;

public interface ISubDepartmentTsVectorRepository : IBaseRepository<SubDepartmentTsVector>
{
    Task<SubDepartmentTsVector?> FindByName(string name, CancellationToken ct);
    Task<List<SubDepartmentTsVector>> FindManyByName(string name, CancellationToken ct);
}