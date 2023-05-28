using Leader02.Application.DtoModels;

namespace Leader02.Application.IServices;

public interface ILegalActService
{
    Task<List<LegalActDto>> FindBySubDepartment(int id, CancellationToken ct);
    Task<List<LegalActDto>> FindByDepartment(int id, CancellationToken ct);
    Task<LegalActDto?> FindByName(string name, CancellationToken ct);
 }