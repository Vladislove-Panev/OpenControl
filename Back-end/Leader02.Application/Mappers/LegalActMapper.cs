using Leader.Domain.Entity;
using Leader02.Application.DtoModels;
using Riok.Mapperly.Abstractions;

namespace Leader02.Application.Mappers;

[Mapper]
public static partial class LegalActMapper
{
    public static partial LegalActDto LegalActToLegalActDto(this LegalAct legalAct);
    public static partial List<LegalActDto> LegalActToLegalActDto(this List<LegalAct> legalAct);
}