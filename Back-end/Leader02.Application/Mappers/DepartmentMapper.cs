using Leader.Domain.Entity;
using Leader02.Application.DtoModels;
using Riok.Mapperly.Abstractions;

namespace Leader02.Application.Mappers;

[Mapper]
public static partial class DepartmentMapper
{
    public static partial DepartmentDto DepartmentToDepartmentDto(this Department department);
    public static partial List<DepartmentDto> DepartmentToDepartmentDto(this List<Department> department);

    public static partial SubDepartmentDto SubDepartmentToSubDepartmentDto(this SubDepartment subDepartment);
    public static partial List<SubDepartmentDto> SubDepartmentToSubDepartmentDto(this List<SubDepartment> subDepartment);
}