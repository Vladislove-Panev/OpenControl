using Leader.Domain.Entity;
using Leader02.Application.DtoModels;
using Riok.Mapperly.Abstractions;

namespace Leader02.Application.Mappers;

[Mapper]
public static partial class UserMapper
{
    public static partial UserDto UserToUserDto(this User requirement);
    public static partial List<UserDto> UsersToUsersDto(this List<User?> requirement);
}