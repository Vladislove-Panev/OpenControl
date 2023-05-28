using Leader.Domain.Entity;

namespace Leader.Domain.Interfaces;

public interface IUserRepository : IBaseRepository<User>
{
    Task<User?> GetById(long id, CancellationToken ct);
    Task<User?> GetByEmail(string email, CancellationToken ct);
    Task<User?> GetByMobilePhone(string mobilePhone, CancellationToken ct);
    Task<User?> GetByEmailAndPassword(string email, string password, CancellationToken ct);
}