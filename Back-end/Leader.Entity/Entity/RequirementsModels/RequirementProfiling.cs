namespace Leader.Domain.Entity.RequirementsModels;

public class RequirementProfiling
{
    /// <summary>
    /// Виды деятельности субъектов контроля, на которые распространяется ОТ (по ОКВЭД 2)
    /// </summary>
    public string? TypesOfActivitiesOfSubjects { get; set; }

    /// <summary>
    /// //Уточнение вида деятельности (при необходимости)
    /// </summary>
    public string? ClarificationOfTypeOdActivity { get; set; }

    /// <summary>
    /// //Характеристика (для общего вопроса)
    /// </summary>
    public string? CharacteristicForGeneralQuestion { get; set; }

    /// <summary>
    /// //Содержание вопроса бизнесу для профилирования (для общего вопроса)
    /// </summary>
    public string? BusinessQuestionContentForProfilingForGeneralQuestion { get; set; }

    /// <summary>
    /// //Характеристика (для уточняющего вопроса)
    /// </summary>
    public string? CharacteristicForClarifyingQuestion { get; set; }

    /// <summary>
    /// //Содержание вопроса бизнесу для профилирования (для уточняющего вопроса)
    /// </summary>
    public string? BusinessQuestionContentForProfilingForClarifyingQuestion { get; set; }
}