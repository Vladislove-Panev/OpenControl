namespace Leader.Domain.Enums.Requirement;

/// <summary>
/// Метод проверки соответствия обязательное требования
/// </summary>
public enum VerificationMethod
{
    Mock, //заглушка
    DocumentsConsideration, //1 - рассмотрение документов
    InspectionAndResearch, //2 - осмотр и обследованиеобъектов (производственных объектов, территорий, транспортных средств и др.)
    ProductsSampling, //3 - отбор образцов продукции, проб и т.п.
    ResearchConducting, //4 - проведение исследований, испытаний образцов продукции, проб
    NetworksParametersMeasurement, //5 - измерение параметров функционирования различных сетей (электроэнергетики, газоснабжения, водоснабжения и др.)
    ComplianceMonitoring, //6 - наблюдение за соблюдением ОТ
    ControlPurchase, //7 - контрольная закупка
    Other //8 - ное
}