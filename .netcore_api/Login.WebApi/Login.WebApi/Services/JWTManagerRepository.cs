using Login.WebApi.Models;
using Microsoft.IdentityModel.Tokens;
using System.IdentityModel.Tokens.Jwt;
using System.Security.Claims;
using System.Text;

namespace Login.WebApi.Services;

public class JWTManagerRepository : IJWTManagerRepository
{
    Dictionary<string, string> UsersRecords = new Dictionary<string, string>
    {
        { "user1","1"},
        { "user2","2"},
        { "user3","3"},
    };

    private readonly IConfiguration iconfiguration;
    public JWTManagerRepository(IConfiguration iconfiguration)
    {
        this.iconfiguration = iconfiguration;
    }
    public Tokens Authenticate(Users users)
    {
        if (!UsersRecords.Any(x => x.Key == users.name && x.Value == users.password))
        {
            return null;
        }

        // Else we generate JSON Web Token
        var tokenHandler = new JwtSecurityTokenHandler();
        var tokenKey = Encoding.UTF8.GetBytes(iconfiguration["JWT:Key"]);
        var tokenDescriptor = new SecurityTokenDescriptor
        {
            Subject = new ClaimsIdentity(new Claim[]
          {
             new Claim(ClaimTypes.Name, users.name)
          }),
            Expires = DateTime.UtcNow.AddMinutes(10),
            SigningCredentials = new SigningCredentials(new SymmetricSecurityKey(tokenKey), SecurityAlgorithms.HmacSha256Signature)
        };
        var token = tokenHandler.CreateToken(tokenDescriptor);
        return new Tokens { Token = tokenHandler.WriteToken(token) };

    }
}
