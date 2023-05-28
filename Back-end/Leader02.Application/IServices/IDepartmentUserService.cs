using Leader02.Application.DtoModels;

namespace Leader02.Application.IServices;

public interface IDepartmentUserService
{
    Task<DepartmentUserDto?> GetById(long id, CancellationToken ct);
}