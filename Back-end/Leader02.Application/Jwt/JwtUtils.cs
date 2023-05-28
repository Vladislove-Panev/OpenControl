using System.IdentityModel.Tokens.Jwt;
using System.Security.Claims;
using System.Text;
using Leader.Domain.Entity;
using Microsoft.IdentityModel.Tokens;

namespace Leader02.Application.Jwt;

public class JwtUtils : IJwtUtils
{
    private readonly IJwtConfig _jwtConfig;

    public JwtUtils(IJwtConfig jwtConfig)
    {
        _jwtConfig = jwtConfig;
        if (string.IsNullOrEmpty(_jwtConfig.SecretJwtKet))
            throw new Exception("JWT secret not configured");
    }

    public string GenerateUserJwtToken(User user)
    {
        var tokenHandler = new JwtSecurityTokenHandler();
        var key = Encoding.ASCII.GetBytes(_jwtConfig.SecretJwtKet);
        var tokenDescriptor = new SecurityTokenDescriptor
        {
            Subject = new ClaimsIdentity(new[]
            {
                new Claim("id", user.Id.ToString()), new Claim("userType", "User")
            }), 
            Expires = DateTime.UtcNow.AddDays(7), 
            SigningCredentials = new SigningCredentials(new SymmetricSecurityKey(key), SecurityAlgorithms.HmacSha256Signature)
        };
        var token = tokenHandler.CreateToken(tokenDescriptor);
        return tokenHandler.WriteToken(token);
    }

    public string GenerateDepartmentUserJwtToken(DepartmentUser user)
    {
        var tokenHandler = new JwtSecurityTokenHandler();
        var key = Encoding.ASCII.GetBytes(_jwtConfig.SecretJwtKet);
        var tokenDescriptor = new SecurityTokenDescriptor
        {
            Subject = new ClaimsIdentity(new[]
            {
                new Claim("id", user.Id.ToString()), new Claim("userType", "DepartmentUser")
            }), 
            Expires = DateTime.UtcNow.AddDays(7), 
            SigningCredentials = new SigningCredentials(new SymmetricSecurityKey(key), SecurityAlgorithms.HmacSha256Signature)
        };
        var token = tokenHandler.CreateToken(tokenDescriptor);
        return tokenHandler.WriteToken(token);
    }

    public (long, string)? ValidateJwtToken(string? token)
    {
        if (token == null)
            return null;

        var tokenHandler = new JwtSecurityTokenHandler();
        var key = Encoding.ASCII.GetBytes(_jwtConfig.SecretJwtKet);
        try
        {
            tokenHandler.ValidateToken(token, new TokenValidationParameters
            {
                ValidateIssuerSigningKey = true, 
                IssuerSigningKey = new SymmetricSecurityKey(key), 
                ValidateIssuer = false, 
                ValidateAudience = false,
                // set clockskew to zero so tokens expire exactly at token expiration time (instead of 5 minutes later)
                ClockSkew = TimeSpan.Zero
            }, out var validatedToken);

            var jwtToken = (JwtSecurityToken) validatedToken;
            var userId = long.Parse(jwtToken.Claims.First(x => x.Type == "id").Value);
            var userType =jwtToken.Claims.First(x => x.Type == "userType").Value;

            // return user id from JWT token if validation successful
            return (userId, userType);
        }
        catch
        {
            // return null if validation fails
            return null;
        }
    }
}