using Leader02.Application.DtoModels;

namespace Leader02.Application.IServices;

public interface IRequirementService
{
    Task<List<RequirementDto>> FindManyBySubDepartment(int id, CancellationToken ct);
    Task<List<RequirementDto>> FindManyByDepartment(int id, CancellationToken ct);
    Task<RequirementDto?> FindByBasicRequirement(string searchString, CancellationToken ct);
    Task<List<RequirementDto>?> FindManyByBasicRequirement(string searchString, CancellationToken ct);
    Task<RequirementDto> FindByBasicRequirementDescription(string basicRequirementDescription, CancellationToken ct);
    Task<RequirementDto> FindByBasicRequirementDetail(string basicRequirementDetail, CancellationToken ct);
}