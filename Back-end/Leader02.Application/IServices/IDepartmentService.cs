using Leader02.Application.DtoModels;

namespace Leader02.Application.IServices;

public interface IDepartmentService
{
    Task<List<DepartmentDto>> GetAll(CancellationToken ct);
}