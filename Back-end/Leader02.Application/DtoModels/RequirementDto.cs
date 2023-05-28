using Leader.Domain.Enums.Requirement;

namespace Leader02.Application.DtoModels;

public class RequirementDto
{
    public long Id { get; set; }
    public int Number { get; set; }
    public string? BasicRequirementDescription { get; set; } // Описание базового требования (группы ОТ)	
    public string? BasicRequirementDetail { get; set; } // Детализация базового требования	
    public RequirementType? RequirementType { get; set; } // Тип требования (1-к субъекту, 0-к объекту)	
    public string RequirementNpasJson { get; set; } = string.Empty; // json с моделей RequirementNpa
    public string RequirementVerificationMethodsJson { get; set; } = string.Empty; // json моделей RequirementVerificationMethod
    public string RequirementResponsibilitiesJson { get; set; } = string.Empty; // json моделей RequirementResponsibility
    public string RequirementProfilingJson { get; set; } = string.Empty; // json моделей RequirementProfiling

    public DepartmentDto? Department { get; set; }
    public SubDepartmentDto? SubDepartment { get; set; }
}