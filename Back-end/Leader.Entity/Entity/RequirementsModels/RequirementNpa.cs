namespace Leader.Domain.Entity.RequirementsModels;

public class RequirementNpa
{
    /// <summary>
    /// //Указание на НПА, ПА (наименование, структурные единицы, текст нормы)
    /// </summary>
    public string? IndicationOfNpa { get; set; }

    /// <summary>
    /// //Период действия НПА (c - по)
    /// </summary>
    public string? ValidityPeriodOfLegalAct { get; set; }

    /// <summary>
    /// //Период действия ОТ (c - по)
    /// </summary>
    public string? ValidityPeriodOfRequirement { get; set; }
}