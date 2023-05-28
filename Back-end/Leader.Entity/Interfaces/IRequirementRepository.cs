using Leader.Domain.Entity;

namespace Leader.Domain.Interfaces;

public interface IRequirementRepository : IBaseRepository<Requirement>
{
    Task<Requirement?> GetById(long id, CancellationToken ct);
    Task<List<Requirement>> GetManyByIds(IEnumerable<long> ids, CancellationToken ct);
    Task<List<Requirement>> FindBySubDepartment(int id, CancellationToken ct);
    Task<List<Requirement>> FindByDepartment(int id, CancellationToken ct);
    Task<List<Requirement>> FindByBasicRequirementDescription(string basicRequirementDescription, CancellationToken ct);
    Task<List<Requirement>> FindByBasicRequirementDetail(string basicRequirementDetail, CancellationToken ct);
}