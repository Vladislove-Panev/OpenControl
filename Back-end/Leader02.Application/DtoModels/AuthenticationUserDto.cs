namespace Leader02.Application.DtoModels;

public class AuthenticationUserDto
{
    public string Message { get; set; } = string.Empty;
    public bool IsAuthenticated { get; set; }
    public string? UserName { get; set; }
    public string? Email { get; set; }
    public string? Role { get; set; }
    public string? Token { get; set; }
}