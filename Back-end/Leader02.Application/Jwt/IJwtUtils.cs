using Leader.Domain.Entity;

namespace Leader02.Application.Jwt;

public interface IJwtUtils
{
    public string GenerateUserJwtToken(User user);
    public string GenerateDepartmentUserJwtToken(DepartmentUser user);
    public (long, string)? ValidateJwtToken(string? token);
}