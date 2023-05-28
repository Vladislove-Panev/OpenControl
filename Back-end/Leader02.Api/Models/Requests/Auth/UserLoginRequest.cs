namespace Leader02.Api.Models.Requests.Auth;

public class UserLoginRequest
{
    public string Email { get; set; } = string.Empty;
    public string Password { get; set; } = string.Empty;
    /// <summary>
    /// Тип пользователя. 0 - User, 1 - AdminUser,
    /// </summary>
    public int UserType { get; set; }
}