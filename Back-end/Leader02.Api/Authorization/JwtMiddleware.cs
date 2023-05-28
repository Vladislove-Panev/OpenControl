using Leader02.Application.IServices;
using Leader02.Application.Jwt;

namespace Leader02.Api.Authorization;

public class JwtMiddleware
{
    private readonly RequestDelegate _next;
    private readonly IUserService _userService;
    private readonly IDepartmentUserService _departmentUserService;

    public JwtMiddleware(RequestDelegate next, IDepartmentUserService departmentUserService, IUserService userService)
    {
        _next = next;
        _departmentUserService = departmentUserService;
        _userService = userService;
    }

    public async Task Invoke(HttpContext context, IAuthService authService, IJwtUtils jwtUtils)
    {
        var token = context.Request.Headers["Authorization"].FirstOrDefault()?.Split(" ").Last();
        var userClaims = jwtUtils.ValidateJwtToken(token);
        if (userClaims?.Item1 != null)
        {
            if (userClaims.Value.Item2 == "User")
            {
                context.Items["User"] = await _userService.GetById(userClaims.Value.Item1, new CancellationToken());
            }
            
            context.Items["User"] = await _departmentUserService.GetById(userClaims.Value.Item1, new CancellationToken());
        }

        await _next(context);
    }
}