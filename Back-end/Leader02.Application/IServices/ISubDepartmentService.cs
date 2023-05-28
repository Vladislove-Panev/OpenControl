using Leader02.Application.DtoModels;

namespace Leader02.Application.IServices;

public interface ISubDepartmentService
{
    Task<SubDepartmentDto?> FindByNameOrDescription(string searchString, CancellationToken ct);
    Task<List<SubDepartmentDto>> GetAllByDepartmentId(int id, CancellationToken ct);
}