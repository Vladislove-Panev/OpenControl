using Leader.Domain.Interfaces;
using Leader02.Application.DtoModels;
using Leader02.Application.IServices;
using Leader02.Application.Mappers;
using Microsoft.Extensions.DependencyInjection;

namespace Leader02.Application.Services;

public class SubDepartmentService : ISubDepartmentService
{
    private readonly ISubDepartmentRepository _subDepartmentRepository;
    private readonly ISubDepartmentTsVectorRepository _subDepartmentTsVectorRepository;

    public SubDepartmentService(IServiceScopeFactory serviceScopeFactory)
    {
        _subDepartmentRepository = serviceScopeFactory.CreateScope().ServiceProvider.GetRequiredService<ISubDepartmentRepository>();
        _subDepartmentTsVectorRepository = serviceScopeFactory.CreateScope().ServiceProvider.GetRequiredService<ISubDepartmentTsVectorRepository>();
    }


    public async Task<SubDepartmentDto?> FindByNameOrDescription(string searchString, CancellationToken ct)
    {
        var subDepartmentTsVectors = await _subDepartmentTsVectorRepository.FindManyByName(searchString, ct);

        if (subDepartmentTsVectors.Count > 0)
        {
            var subDepartment = await _subDepartmentRepository.GetById(subDepartmentTsVectors[0].Id, ct);
            if (subDepartment != null) return subDepartment.SubDepartmentToSubDepartmentDto();
        }

        return null;
    }

    public async Task<List<SubDepartmentDto>> GetAllByDepartmentId(int id, CancellationToken ct)
    {
        var subDepartments = await _subDepartmentRepository.GetAllByDepartmentId(id, ct);
        return subDepartments.SubDepartmentToSubDepartmentDto();
    }
}