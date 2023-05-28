using Leader.Domain.Entity;

namespace Leader.Domain.Interfaces;

public interface IDepartmentUserRepository : IBaseRepository<DepartmentUser>
{
    Task<DepartmentUser?> GetById(long id, CancellationToken ct);
    Task<DepartmentUser?> GetByEmail(string email, CancellationToken ct);
    Task<DepartmentUser?> GetByMobilePhone(string mobilePhone, CancellationToken ct);
    Task<DepartmentUser?> GetByEmailAndPassword(string email, string password, CancellationToken ct);
}