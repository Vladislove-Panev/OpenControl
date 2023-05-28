using Leader02.Application.DtoModels;

namespace Leader02.Application.IServices;

public interface IAuthService
{
    Task<AuthenticationUserDto?> Authenticate(string email, string password, int userType, CancellationToken ct);
    Task<UserDto?> Register(string firstName, string lastName, string? middleName, string email, string mobilePhone, string password, string repeatPassword,
        string? ditSecurityQuestion, string? ditSecurityAnswer, CancellationToken ct);
}