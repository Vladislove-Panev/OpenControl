using Leader.Domain.Enums.Requirement;

namespace Leader.Domain.Entity.RequirementsModels;

public class RequirementVerificationMethod
{
    /// <summary>
    /// Метод проверки  соответствия ОТ 1-8
    /// </summary>
    public VerificationMethod VerificationMethod { get; set; } = VerificationMethod.Mock;

    /// <summary>
    /// json модели VerificationMethodDocument
    /// </summary>
    public string VerificationMethodDocumentsJson { get; set; } = string.Empty;
}