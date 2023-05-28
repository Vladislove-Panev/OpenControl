namespace Leader02.Api.Models.Requests.Auth;

public class AdminUserLoginRequest
{
    public string UserName { get; set; } = string.Empty;
    public string Password { get; set; } = string.Empty;
}