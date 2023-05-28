using Leader.Domain.Entity;
using Leader02.Application.DtoModels;
using Riok.Mapperly.Abstractions;

namespace Leader02.Application.Mappers;

[Mapper]
public static partial class DepartmentUserMapper
{
    public static partial DepartmentUserDto? DepartmentUserToDepartmentUserDto(this DepartmentUser requirement);
    public static partial List<DepartmentUserDto> DepartmentUsersToDepartmentUsersDto(this List<DepartmentUser?> requirement);
}