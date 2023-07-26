using Login.WebApi.Models;

namespace Login.WebApi.Services;

public interface IJWTManagerRepository
{
    Tokens Authenticate(Users users);
}
