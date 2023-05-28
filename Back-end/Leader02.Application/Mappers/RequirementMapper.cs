using Leader.Domain.Entity;
using Leader02.Application.DtoModels;
using Riok.Mapperly.Abstractions;

namespace Leader02.Application.Mappers;

[Mapper]
public static partial class RequirementMapper
{
    public static partial RequirementDto RequirementToRequirementDto(this Requirement requirement);
    public static partial List<RequirementDto> RequirementToRequirementDto(this List<Requirement?> requirement);
}