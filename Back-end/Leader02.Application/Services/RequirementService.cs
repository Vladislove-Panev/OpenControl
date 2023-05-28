using Leader.Domain.Interfaces;
using Leader02.Application.DtoModels;
using Leader02.Application.IServices;
using Leader02.Application.Mappers;
using Microsoft.Extensions.DependencyInjection;

namespace Leader02.Application.Services;

public class RequirementService : IRequirementService
{
    private readonly IRequirementRepository _requirementRepository;
    private readonly IRequirementTsVectorRepository _requirementTsVectorRepository;

    public RequirementService(IServiceScopeFactory serviceScopeFactory)
    {
        _requirementRepository = serviceScopeFactory.CreateScope().ServiceProvider.GetRequiredService<IRequirementRepository>();
        _requirementTsVectorRepository = serviceScopeFactory.CreateScope().ServiceProvider.GetRequiredService<IRequirementTsVectorRepository>();
    }

    public Task<List<RequirementDto>> FindManyBySubDepartment(int id, CancellationToken ct)
    {
        throw new NotImplementedException();
    }

    public Task<List<RequirementDto>> FindManyByDepartment(int id, CancellationToken ct)
    {
        throw new NotImplementedException();
    }

    public async Task<RequirementDto?> FindByBasicRequirement(string searchString, CancellationToken ct)
    {
        var requirementTsVector = await _requirementTsVectorRepository.FindByBasicRequirement(searchString, ct);

        if (requirementTsVector != null)
        {
            var requirement = await _requirementRepository.GetById(requirementTsVector.Id, ct);

            if (requirement != null) return requirement.RequirementToRequirementDto();
        }

        return null;
    }

    public async Task<List<RequirementDto>?> FindManyByBasicRequirement(string searchString, CancellationToken ct)
    {
        var requirementTsVectors = await _requirementTsVectorRepository.FindManyByBasicRequirement(searchString, ct);

        if (requirementTsVectors.Count > 0)
        {
            var requirementIds = requirementTsVectors
                .Where(x => x.Number == requirementTsVectors[0].Number)
                .Select(x => x.Id)
                .ToArray();

            var requirements = await _requirementRepository.GetManyByIds(requirementIds, ct);

            return requirements.RequirementToRequirementDto();
        }

        return null;
    }

    public Task<RequirementDto> FindByBasicRequirementDescription(string basicRequirementDescription, CancellationToken ct)
    {
        throw new NotImplementedException();
    }

    public Task<RequirementDto> FindByBasicRequirementDetail(string basicRequirementDetail, CancellationToken ct)
    {
        throw new NotImplementedException();
    }
}