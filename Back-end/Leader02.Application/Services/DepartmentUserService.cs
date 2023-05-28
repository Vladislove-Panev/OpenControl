using Leader.Domain.Interfaces;
using Leader02.Application.DtoModels;
using Leader02.Application.IServices;
using Leader02.Application.Mappers;
using Microsoft.Extensions.DependencyInjection;

namespace Leader02.Application.Services;

public class DepartmentUserService : IDepartmentUserService
{
    private readonly IDepartmentUserRepository _departmentUserRepository;

    public DepartmentUserService(IServiceScopeFactory serviceScopeFactory)
    {
        _departmentUserRepository = serviceScopeFactory.CreateScope().ServiceProvider.GetRequiredService<IDepartmentUserRepository>();
    }

    public async Task<DepartmentUserDto?> GetById(long id, CancellationToken ct)
    {
        var departmentUser = await _departmentUserRepository.GetById(id, ct);
        return departmentUser?.DepartmentUserToDepartmentUserDto();
    }
}