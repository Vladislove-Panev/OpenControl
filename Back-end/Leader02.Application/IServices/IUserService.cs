using Leader02.Application.DtoModels;

namespace Leader02.Application.IServices;

public interface IUserService
{
    Task<UserDto?> GetById(long id, CancellationToken ct);
}