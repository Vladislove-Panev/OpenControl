using Leader.Domain.Enums;

namespace Leader02.Application.DtoModels;

public class UserDto
{
    public long Id { get; set; }
    public string FirstName { get; set; } = string.Empty;
    public string LastName { get; set; } = string.Empty;
    public string? MiddleName { get; set; } = string.Empty;
    public string MobilePhone { get; set; } = string.Empty;
    public string Email { get; set; } = string.Empty;
    public UserType UserType { get; set; }
    public int? Inn { get; set; }
    public int? Snils { get; set; }
    public int? Kpp { get; set; }
    public int? Okveds { get; set; }
    public string? DitSecurityQuestion { get; set; }
    public string? DitSecurityAnswer { get; set; }
}