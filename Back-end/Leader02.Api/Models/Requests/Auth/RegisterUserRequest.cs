namespace Leader02.Api.Models.Requests.Auth;

public class RegisterUserRequest
{
    public string FirstName { get; set; } = string.Empty;
    public string LastName { get; set; } = string.Empty;
    public string Email { get; set; } = string.Empty;
    public string MobilePhone { get; set; } = string.Empty;
    public string Password { get; set; } = string.Empty;
    public string RepeatPassword { get; set; } = string.Empty;
    public string? DitSecurityQuestion { get; set; }
    public string? DitSecurityAnswer { get; set; }
    public string? MiddleName { get; set; }
}