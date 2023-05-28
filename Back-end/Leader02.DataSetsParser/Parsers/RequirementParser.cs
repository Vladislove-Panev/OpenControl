using Leader.Domain.Entity;
using Leader.Domain.Entity.RequirementsModels;
using Leader.Domain.Enums.Requirement;
using Leader02.Infrastructure;
using Microsoft.EntityFrameworkCore;
using Newtonsoft.Json;
using OfficeOpenXml;

namespace Leader02.DataSetsParser.Parsers;

public class RequirementParser
{
    private readonly Leader02Context _context;

    public RequirementParser(Leader02Context context)
    {
        _context = context;
    }

    public void RequirementParsing()
    {
        Parsing(3,"C:\\Users\\Romtila\\Desktop\\Датасеты\\Приложение_1_Список_обязательных_требований_КНО_Москвы\\ГИН\\Земельный контроль 22 ОТ\\22 ОТ.xlsx");
        Parsing(2,"C:\\Users\\Romtila\\Desktop\\Датасеты\\Приложение_1_Список_обязательных_требований_КНО_Москвы\\ГИН\\Нежилой фонд 7 ОТ\\7 от.xlsx");
        Parsing(1,"C:\\Users\\Romtila\\Desktop\\Датасеты\\Приложение_1_Список_обязательных_требований_КНО_Москвы\\Главархив\\Архивное дело 38 ОТ\\38 ОТ.xlsx");
        Parsing(19,"C:\\Users\\Romtila\\Desktop\\Датасеты\\Приложение_1_Список_обязательных_требований_КНО_Москвы\\ГОЧСиПБ\\ЧС 22 ОТ\\22 ОТ.xlsx");
        Parsing(24,"C:\\Users\\Romtila\\Desktop\\Датасеты\\Приложение_1_Список_обязательных_требований_КНО_Москвы\\Департамент культуры г.Москвы\\Достоверность 6 ОТ\\6 ОТ.xlsx");
        Parsing(23,"C:\\Users\\Romtila\\Desktop\\Датасеты\\Приложение_1_Список_обязательных_требований_КНО_Москвы\\Департамент культуры г.Москвы\\Музейный фонд 594 ОТ\\594 ОТ.xlsx");
        Parsing(4,"C:\\Users\\Romtila\\Desktop\\Датасеты\\Приложение_1_Список_обязательных_требований_КНО_Москвы\\ДЗМ\\Лекарственные препараты 5 ОТ\\5 ОТ.xlsx");
        Parsing(19,"C:\\Users\\Romtila\\Desktop\\Датасеты\\Приложение_1_Список_обязательных_требований_КНО_Москвы\\ДОНМ\\Контроль в сфере образования 143 ОТ\\143 ОТ.xlsx");
        Parsing(17,"C:\\Users\\Romtila\\Desktop\\Датасеты\\Приложение_1_Список_обязательных_требований_КНО_Москвы\\ДТРТДИ\\Внеуличный транспорт 8 ОТ\\8 ОТ.xlsx");
        Parsing(8,"C:\\Users\\Romtila\\Desktop\\Датасеты\\Приложение_1_Список_обязательных_требований_КНО_Москвы\\ДТСЗН\\Инвалиды 2 ОТ\\2 ОТ.xlsx");
        Parsing(9,"C:\\Users\\Romtila\\Desktop\\Датасеты\\Приложение_1_Список_обязательных_требований_КНО_Москвы\\ДТСЗН\\Молодежь 2 ОТ\\2 ОТ.xlsx");
        Parsing(7,"C:\\Users\\Romtila\\Desktop\\Датасеты\\Приложение_1_Список_обязательных_требований_КНО_Москвы\\ДТСЗН\\Социальное обслуживание 37 ОТ\\37 ОТ.xlsx");
        Parsing(25,"C:\\Users\\Romtila\\Desktop\\Датасеты\\Приложение_1_Список_обязательных_требований_КНО_Москвы\\ДЭПР\\Водоснабжение 6 ОТ\\6 ОТ.xlsx");
        Parsing(29,"C:\\Users\\Romtila\\Desktop\\Датасеты\\Приложение_1_Список_обязательных_требований_КНО_Москвы\\ДЭПР\\Газоснабжение 2 ОТ\\2 ОТ.xlsx");
        Parsing(27,"C:\\Users\\Romtila\\Desktop\\Датасеты\\Приложение_1_Список_обязательных_требований_КНО_Москвы\\ДЭПР\\Монополии 19 ОТ\\19 ОТ.xlsx");
        Parsing(30,"C:\\Users\\Romtila\\Desktop\\Датасеты\\Приложение_1_Список_обязательных_требований_КНО_Москвы\\ДЭПР\\Теплоснабжение 6 ОТ\\6 ОТ.xlsx");
        Parsing(26,"C:\\Users\\Romtila\\Desktop\\Датасеты\\Приложение_1_Список_обязательных_требований_КНО_Москвы\\ДЭПР\\ТКО 3 ОТ\\3 ОТ.xlsx");
        Parsing(28,"C:\\Users\\Romtila\\Desktop\\Датасеты\\Приложение_1_Список_обязательных_требований_КНО_Москвы\\ДЭПР\\Электроэнергетика 7 ОТ\\7 ОТ.xlsx");
        Parsing(14,"C:\\Users\\Romtila\\Desktop\\Датасеты\\Приложение_1_Список_обязательных_требований_КНО_Москвы\\МАДИ\\Такси 25 ОТ\\25 ОТ.xlsx");
        Parsing(43,"C:\\Users\\Romtila\\Desktop\\Датасеты\\Приложение_1_Список_обязательных_требований_КНО_Москвы\\Мосгосстройнадзор\\Горный 22 ОТ\\22 ОТ.xlsx");
        Parsing(45,"C:\\Users\\Romtila\\Desktop\\Датасеты\\Приложение_1_Список_обязательных_требований_КНО_Москвы\\Мосгосстройнадзор\\Промышленная безопасность 20 ОТ\\20 ОТ.xlsx");
        Parsing(46,"C:\\Users\\Romtila\\Desktop\\Датасеты\\Приложение_1_Список_обязательных_требований_КНО_Москвы\\Мосгосстройнадзор\\Строительный 6 ОТ\\6 ОТ.xlsx");
        Parsing(47,"C:\\Users\\Romtila\\Desktop\\Датасеты\\Приложение_1_Список_обязательных_требований_КНО_Москвы\\Мосгосстройнадзор\\Строительный в Москве 7 ОТ\\7 ОТ.xlsx");
        Parsing(44,"C:\\Users\\Romtila\\Desktop\\Датасеты\\Приложение_1_Список_обязательных_требований_КНО_Москвы\\Мосгосстройнадзор\\Энергетический 12 ОТ\\12 ОТ.xlsx");
        Parsing(5,"C:\\Users\\Romtila\\Desktop\\Датасеты\\Приложение_1_Список_обязательных_требований_КНО_Москвы\\Москомвет\\Обращение с животными в г. Москве 40 ОТ\\40 ОТ.xlsx");
        Parsing(42,"C:\\Users\\Romtila\\Desktop\\Датасеты\\Приложение_1_Список_обязательных_требований_КНО_Москвы\\Москомстройинвест\\Долевое строительство 108 ОТ\\108 ОТ.xlsx");
        Parsing(41,"C:\\Users\\Romtila\\Desktop\\Датасеты\\Приложение_1_Список_обязательных_требований_КНО_Москвы\\Москомстройинвест\\Жилищно-строительные кооперативы 9 ОТ\\9 ОТ.xlsx");
        Parsing(37,"C:\\Users\\Romtila\\Desktop\\Датасеты\\Приложение_1_Список_обязательных_требований_КНО_Москвы\\Мосприрода\\Геологический контроль 28 ОТ\\28 ОТ.xlsx");
        Parsing(36,"C:\\Users\\Romtila\\Desktop\\Датасеты\\Приложение_1_Список_обязательных_требований_КНО_Москвы\\Мосприрода\\Городские почвы 10 ОТ\\10 ОТ.xlsx");
        Parsing(35,"C:\\Users\\Romtila\\Desktop\\Датасеты\\Приложение_1_Список_обязательных_требований_КНО_Москвы\\Мосприрода\\Зеленые насаждения 145 ОТ\\145 ОТ.xlsx");
        Parsing(38,"C:\\Users\\Romtila\\Desktop\\Датасеты\\Приложение_1_Список_обязательных_требований_КНО_Москвы\\Мосприрода\\Лицензионный контроль металлы 98 ОТ\\98 ОТ.xlsx");
        Parsing(32,"C:\\Users\\Romtila\\Desktop\\Датасеты\\Приложение_1_Список_обязательных_требований_КНО_Москвы\\Мосприрода\\Особо охраняемые природные территории 31 ОТ\\31 ОТ.xlsx");
        Parsing(31,"C:\\Users\\Romtila\\Desktop\\Датасеты\\Приложение_1_Список_обязательных_требований_КНО_Москвы\\Мосприрода\\Охотничий контроль 8 ОТ\\8 ОТ.xlsx");
        Parsing(33,"C:\\Users\\Romtila\\Desktop\\Датасеты\\Приложение_1_Список_обязательных_требований_КНО_Москвы\\Мосприрода\\ФЕД охрана, воспроизводство и использования объектов 9 ОТ\\9 ОТ.xlsx");
        Parsing(34,"C:\\Users\\Romtila\\Desktop\\Датасеты\\Приложение_1_Список_обязательных_требований_КНО_Москвы\\Мосприрода\\Эколгический контроль 202 ОТ\\202 ОТ.xlsx");
        Parsing(11,"C:\\Users\\Romtila\\Desktop\\Датасеты\\Приложение_1_Список_обязательных_требований_КНО_Москвы\\ОАТИ\\Благоустройство 1010 ОТ\\1010 ОТ.xlsx");
        Parsing(10,"C:\\Users\\Romtila\\Desktop\\Датасеты\\Приложение_1_Список_обязательных_требований_КНО_Москвы\\ОАТИ\\Самоходки и аттракционы 57 ОТ\\57 ОТ.xlsx");
    }

    public void Parsing(int subDepartmentId, string fileName)
    {
        var subDepartment = _context.SubDepartments
            .Include(x => x.Department)
            .FirstOrDefault(x => x.Id == subDepartmentId);

        var existingFile = new FileInfo(fileName);

        using var package = new ExcelPackage(existingFile);
        
        var worksheet = package.Workbook.Worksheets[0];
        
        #region объявление переменных
        
        var number = _context.Requirements.OrderByDescending(x => x.Id).FirstOrDefault()?.Number + 1 ?? 0;//номер требования
        
        var requirements = new List<Requirement>(worksheet.Dimension.Rows);
        var requirementNpas = new List<RequirementNpa>();
        var requirementProfilings = new List<RequirementProfiling>();
        var requirementResponsibilities = new List<RequirementResponsibility>();
        
        var basicRequirementDescription = string.Empty;
        var basicRequirementDetail = string.Empty;

        var requirementVerificationMethod = new RequirementVerificationMethod();
        var requirementVerificationMethods = new List<RequirementVerificationMethod>();
        var verificationMethodDocuments = new List<VerificationMethodDocument>();
        
        var requirementResponsibility = new RequirementResponsibility();
        
        var sanctionInfos = new List<SanctionInfo>();

        var requirement = new Requirement
        {
            SubDepartment = subDepartment,
            Department = subDepartment?.Department
        };

        #endregion
        
        for (var i = 3; i <= worksheet.Dimension.Rows + 1; i++)
        {
            if (i == worksheet.Dimension.Rows + 1)
            {
                requirements.Add(requirement);
            }
                        
            if (worksheet.Cells[i, 3].Value != null && worksheet.Cells[i, 3].Value.ToString() != string.Empty)
            {
                if (!string.IsNullOrEmpty(basicRequirementDetail))
                {
                    requirement.RequirementNpasJson = JsonConvert.SerializeObject(requirementNpas);
                    requirement.RequirementProfilingJson = JsonConvert.SerializeObject(requirementProfilings);
                    requirement.RequirementResponsibilitiesJson = JsonConvert.SerializeObject(requirementResponsibilities);
                    requirement.RequirementVerificationMethodsJson = JsonConvert.SerializeObject(requirementVerificationMethods);
                    requirements.Add(requirement);
                    requirementNpas = new List<RequirementNpa>();
                    requirementProfilings = new List<RequirementProfiling>();
                    requirementResponsibilities = new List<RequirementResponsibility>();
                    requirementVerificationMethods = new List<RequirementVerificationMethod>();
                }

                basicRequirementDescription = worksheet.Cells[i, 3].Value.ToString();
                basicRequirementDetail = string.Empty;
                requirementNpas.Clear(); 
                requirementProfilings.Clear();
                requirementVerificationMethods.Clear();
                requirementResponsibilities.Clear();
                
             continue;
            }

            if (worksheet.Cells[i, 4].Value!= null && worksheet.Cells[i, 4].Value.ToString() != string.Empty)
            {
                number += 1;
                
                if (!string.IsNullOrEmpty(requirement.BasicRequirementDetail))
                {
                    requirement.RequirementNpasJson = JsonConvert.SerializeObject(requirementNpas);
                    requirement.RequirementProfilingJson = JsonConvert.SerializeObject(requirementProfilings);
                    requirement.RequirementResponsibilitiesJson = JsonConvert.SerializeObject(requirementResponsibilities);
                    requirement.RequirementVerificationMethodsJson = JsonConvert.SerializeObject(requirementVerificationMethods);
                    requirements.Add(requirement);
                    requirementNpas = new List<RequirementNpa>();
                    requirementProfilings = new List<RequirementProfiling>();
                    requirementResponsibilities = new List<RequirementResponsibility>();
                    requirementVerificationMethods = new List<RequirementVerificationMethod>();
                }

                basicRequirementDetail = worksheet.Cells[i, 4].Value.ToString();
                requirement = new Requirement
                {
                    BasicRequirementDescription = basicRequirementDescription,
                    BasicRequirementDetail = basicRequirementDetail,
                    Number = number,
                    SubDepartment = subDepartment,
                    Department = subDepartment?.Department,
                    RequirementBasicRequirement = new RequirementTsVector
                    {
                        Number = number, 
                        BasicRequirement =basicRequirementDescription + " " + basicRequirementDetail
                    }
                };
                basicRequirementDetail = worksheet.Cells[i, 4].Value.ToString();
            }

            if (worksheet.Cells[i, 5].Value != null && worksheet.Cells[i, 5].Value.ToString() != string.Empty)
            {
                var requirementType = worksheet.Cells[i, 5].Value.ToString() == "1"
                    ? RequirementType.Subject
                    : RequirementType.Object;

                requirement.RequirementType = requirementType;
            }
 
            #region НПА
            
            var requirementNpa = new RequirementNpa();
            
            if (worksheet.Cells[i, 6].Value != null && worksheet.Cells[i, 6].Value.ToString() != string.Empty)
            {
                requirementNpa.IndicationOfNpa = worksheet.Cells[i, 6].Value.ToString();
            }

            if (worksheet.Cells[i, 7].Value != null && worksheet.Cells[i, 7].Value.ToString() != string.Empty)
            {
                requirementNpa.ValidityPeriodOfLegalAct = worksheet.Cells[i, 7].Value.ToString();
            }

            if (worksheet.Cells[i, 8].Value != null && worksheet.Cells[i, 8].Value.ToString() != string.Empty)
            {
                requirementNpa.ValidityPeriodOfRequirement = worksheet.Cells[i, 8].Value.ToString();
            }

            if(!string.IsNullOrEmpty(requirementNpa.IndicationOfNpa))
                requirementNpas.Add(requirementNpa);
            
            #endregion
            
            #region Подтверждение соответствия
            
            if (worksheet.Cells[i, 9].Value != null && worksheet.Cells[i, 9].Value.ToString() != string.Empty)
            {
                if(requirementVerificationMethod.VerificationMethod != VerificationMethod.Mock)
                {
                    requirementVerificationMethod.VerificationMethodDocumentsJson = JsonConvert.SerializeObject(verificationMethodDocuments);
                    requirementVerificationMethods.Add(requirementVerificationMethod);
                    requirementVerificationMethod = new RequirementVerificationMethod();
                    verificationMethodDocuments = new List<VerificationMethodDocument>();
                }
                
                requirementVerificationMethod.VerificationMethod = worksheet.Cells[i, 9].Value.ToString() switch
                {
                    "1" => VerificationMethod.DocumentsConsideration
                    , "2" => VerificationMethod.InspectionAndResearch
                    , "3" => VerificationMethod.ProductsSampling
                    , "5" => VerificationMethod.NetworksParametersMeasurement
                    , "6" => VerificationMethod.ComplianceMonitoring
                    , "4" => VerificationMethod.ResearchConducting
                    , "7" => VerificationMethod.ControlPurchase
                    , "8" => VerificationMethod.Other
                    , _ => VerificationMethod.Mock
                };
                
            }

            var verificationMethodDocument = new VerificationMethodDocument();
            
            if (worksheet.Cells[i, 10].Value != null && worksheet.Cells[i, 10].Value.ToString() != string.Empty)
            {
                verificationMethodDocument.ConfirmingComplianceDocuments = worksheet.Cells[i, 10].Value.ToString();
            }
            
            if (worksheet.Cells[i, 11].Value != null && worksheet.Cells[i, 11].Value.ToString() != string.Empty)
            {
                verificationMethodDocument.Ogv = worksheet.Cells[i, 11].Value.ToString();
            }
            
            if (worksheet.Cells[i, 12].Value != null && worksheet.Cells[i, 12].Value.ToString() != string.Empty)
            {
                verificationMethodDocument.PossibilityOfDocumentsObtaining = worksheet.Cells[i, 12].Value.ToString();
            }
            
            if (worksheet.Cells[i, 13].Value != null && worksheet.Cells[i, 13].Value.ToString() != string.Empty)
            {
                verificationMethodDocument.SupportingDocumentsValidity = worksheet.Cells[i, 13].Value.ToString();
            }
            
            if(!string.IsNullOrEmpty(verificationMethodDocument.SupportingDocumentsValidity) ||
               !string.IsNullOrEmpty(verificationMethodDocument.PossibilityOfDocumentsObtaining) ||
               !string.IsNullOrEmpty(verificationMethodDocument.ConfirmingComplianceDocuments) ||
               !string.IsNullOrEmpty(verificationMethodDocument.Ogv))
                verificationMethodDocuments.Add(verificationMethodDocument);
            
            #endregion
            
            #region Ответственность
            
            if (worksheet.Cells[i, 14].Value != null && worksheet.Cells[i, 14].Value.ToString() != string.Empty)
            {
                if (!string.IsNullOrEmpty(requirementResponsibility.TypeOfLiability))
                {
                    requirementResponsibility.SanctionInfoJson = JsonConvert.SerializeObject(sanctionInfos);
                    requirementResponsibilities.Add(requirementResponsibility);
                    requirementResponsibility = new RequirementResponsibility();
                    sanctionInfos = new List<SanctionInfo>();
                }
                
                requirementResponsibility.TypeOfLiability = worksheet.Cells[i, 14].Value.ToString();
            }
            
            
            var sanctionInfo = new SanctionInfo();
            
            if (worksheet.Cells[i, 15].Value != null && worksheet.Cells[i, 15].Value.ToString() != string.Empty)
            {
                sanctionInfo.SubjectOfResponsibility = worksheet.Cells[i, 15].Value.ToString();
            }

            if (worksheet.Cells[i, 16].Value != null && worksheet.Cells[i, 16].Value.ToString() != string.Empty)
            {
                sanctionInfo.Sanction = worksheet.Cells[i, 16].Value.ToString();
            }
            
            if (worksheet.Cells[i, 17].Value != null && worksheet.Cells[i, 17].Value.ToString() != string.Empty)
            {
                sanctionInfo.SizeOfSanction = worksheet.Cells[i, 17].Value.ToString();
            }
            
            if(!string.IsNullOrEmpty(sanctionInfo.SubjectOfResponsibility) ||
               !string.IsNullOrEmpty(sanctionInfo.SizeOfSanction) ||
               !string.IsNullOrEmpty(sanctionInfo.Sanction))
                sanctionInfos.Add(sanctionInfo);
            
            
            if (worksheet.Cells[i, 18].Value != null && worksheet.Cells[i, 18].Value.ToString() != string.Empty)
            {
                requirementResponsibility.TypeOfNorm = worksheet.Cells[i, 18].Value.ToString();
            }
                        
            if (worksheet.Cells[i, 19].Value != null && worksheet.Cells[i, 19].Value.ToString() != string.Empty)
            {
                requirementResponsibility.ReferenceToLegalAct = worksheet.Cells[i, 19].Value.ToString();
            }

            if (worksheet.Cells[i, 20].Value != null && worksheet.Cells[i, 20].Value.ToString() != string.Empty)
            {
                requirementResponsibility.EmpoweredToHoldAuthority = worksheet.Cells[i, 20].Value.ToString();
            }
            
            if (worksheet.Cells[i, 21].Value != null && worksheet.Cells[i, 21].Value.ToString() != string.Empty)
            {
                requirementResponsibility.ResponsibilityBringingProcedure = worksheet.Cells[i, 21].Value.ToString();
            }
            
            #endregion
            
            #region Профилирование

            var requirementProfiling = new RequirementProfiling();
            
            if (worksheet.Cells[i, 22].Value != null && worksheet.Cells[i, 22].Value.ToString() != string.Empty)
            {
                requirementProfiling.TypesOfActivitiesOfSubjects = worksheet.Cells[i, 22].Value.ToString();
            }
            
            if (worksheet.Cells[i, 23].Value != null && worksheet.Cells[i, 23].Value.ToString() != string.Empty)
            {
                requirementProfiling.ClarificationOfTypeOdActivity = worksheet.Cells[i, 23].Value.ToString();
            }
            
            if (worksheet.Cells[i, 24].Value != null && worksheet.Cells[i, 24].Value.ToString() != string.Empty)
            {
                requirementProfiling.CharacteristicForGeneralQuestion = worksheet.Cells[i, 24].Value.ToString();
            }
            
            if (worksheet.Cells[i, 25].Value != null && worksheet.Cells[i, 25].Value.ToString() != string.Empty)
            {
                requirementProfiling.BusinessQuestionContentForProfilingForGeneralQuestion = worksheet.Cells[i, 25].Value.ToString();
            }
            
            if (worksheet.Cells[i, 26].Value != null && worksheet.Cells[i, 26].Value.ToString() != string.Empty)
            {
                requirementProfiling.CharacteristicForClarifyingQuestion = worksheet.Cells[i, 26].Value.ToString();
            }
            
            if (worksheet.Cells[i, 27].Value != null && worksheet.Cells[i, 27].Value.ToString() != string.Empty)
            {
                requirementProfiling.BusinessQuestionContentForProfilingForClarifyingQuestion = worksheet.Cells[i, 27].Value.ToString();
            }
            
            if(!string.IsNullOrEmpty(requirementProfiling.TypesOfActivitiesOfSubjects) ||
               !string.IsNullOrEmpty(requirementProfiling.ClarificationOfTypeOdActivity) ||
               !string.IsNullOrEmpty(requirementProfiling.CharacteristicForGeneralQuestion) ||
               !string.IsNullOrEmpty(requirementProfiling.CharacteristicForClarifyingQuestion) ||
               !string.IsNullOrEmpty(requirementProfiling.BusinessQuestionContentForProfilingForGeneralQuestion) ||
               !string.IsNullOrEmpty(requirementProfiling.BusinessQuestionContentForProfilingForClarifyingQuestion))
                requirementProfilings.Add(requirementProfiling);
            
            #endregion
        }

        requirements = requirements.Where(x => x.Number != 0).ToList();
        
        _context.Requirements.AddRange(requirements);
        _context.SaveChanges();
    }
}