using Leader.Domain.Interfaces;
using Leader02.Application.DtoModels;
using Leader02.Application.IServices;
using Leader02.Application.Mappers;
using Microsoft.Extensions.DependencyInjection;

namespace Leader02.Application.Services;

public class DepartmentService : IDepartmentService
{
    private readonly IDepartmentRepository _departmentRepository;

    public DepartmentService(IServiceScopeFactory serviceScopeFactory)
    {
        _departmentRepository = serviceScopeFactory.CreateScope().ServiceProvider.GetRequiredService<IDepartmentRepository>();
    }

    public async Task<List<DepartmentDto>> GetAll(CancellationToken ct)
    {
        var departments = await _departmentRepository.GetAll(ct);
        return departments.DepartmentToDepartmentDto();
    }
}