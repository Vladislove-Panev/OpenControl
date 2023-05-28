namespace Leader.Domain.Entity.RequirementsModels;

public class VerificationMethodDocument
{
    /// <summary>
    /// Документы, подтверждающие  соответствие субъекта/объекта контроля ОТ (если применимо)
    /// </summary>
    public string? ConfirmingComplianceDocuments { get; set; }

    /// <summary>
    /// ОГВ (ОМСУ), организации, в распоряжении которых находятся необходимые сведения (уполномоченные на выдачу подтверждающих документов)
    /// </summary>
    public string? Ogv { get; set; }

    /// <summary>
    /// Возможность получения КНО необходимых подтверждающих документов/сведений по межведомственному взаимодействию (да/нет)
    /// </summary>
    public string? PossibilityOfDocumentsObtaining { get; set; }

    /// <summary>
    /// Срок действия подтверждающих документов (если применимо)
    /// </summary>
    public string? SupportingDocumentsValidity { get; set; }
}