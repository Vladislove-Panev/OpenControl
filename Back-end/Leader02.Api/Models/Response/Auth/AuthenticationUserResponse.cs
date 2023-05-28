namespace Leader02.Api.Models.Response.Auth;

public class AuthenticationUserResponse
{
    public string Message { get; set; } = string.Empty;
    public bool IsAuthenticated { get; set; }
    public string? UserName { get; set; }
    public string? Email { get; set; }
    public string? Role { get; set; }
    public string? Token { get; set; }
}