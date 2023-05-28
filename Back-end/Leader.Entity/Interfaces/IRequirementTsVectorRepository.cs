using Leader.Domain.Entity;

namespace Leader.Domain.Interfaces;

public interface IRequirementTsVectorRepository : IBaseRepository<RequirementTsVector>
{
    Task<RequirementTsVector?> FindByBasicRequirement(string basicRequirementDetail, CancellationToken ct);
    Task<List<RequirementTsVector>> FindManyByBasicRequirement(string basicRequirementDetail, CancellationToken ct);
}