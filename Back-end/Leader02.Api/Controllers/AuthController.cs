using Leader02.Api.Models.Requests.Auth;
using Leader02.Application.IServices;
using Microsoft.AspNetCore.Mvc;

namespace Leader02.Api.Controllers;

[ApiController]
[Route("[controller]")]
public class AuthController : ControllerBase
{
    private readonly IAuthService _authService;

    public AuthController(IAuthService authService)
    {
        _authService = authService;
    }

    [HttpPost("authenticate")]
    public async Task<IActionResult> Authenticate([FromBody] UserLoginRequest model, CancellationToken ct)
    {
        var response = await _authService.Authenticate(model.Email, model.Password, model.UserType, ct);

        if (response == null)
            return BadRequest(new {message = "Username or password is incorrect"});

        return Ok(response);
    }

    [HttpPost("register")]
    public async Task<IActionResult> Register([FromBody] RegisterUserRequest model, CancellationToken ct)
    {
        var response = await _authService.Register(model.FirstName, model.LastName, model.MiddleName, model.Email,
            model.MobilePhone, model.Password, model.RepeatPassword, model.DitSecurityQuestion, model.DitSecurityAnswer, ct);

        if (response == null)
            return BadRequest(new {message = "User with your email already exist"});

        return Ok(response);
    }
}