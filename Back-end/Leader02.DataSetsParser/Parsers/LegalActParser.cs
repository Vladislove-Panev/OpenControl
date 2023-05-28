using System.Globalization;
using Leader.Domain.Entity;
using Leader02.Infrastructure;
using Microsoft.EntityFrameworkCore;
using OfficeOpenXml;

namespace Leader02.DataSetsParser.Parsers;

public class LegalActParser
{
    private readonly Leader02Context _context;

    public LegalActParser(Leader02Context context)
    {
        _context = context;
    }

    public void LegalActParsing(string fileName)
    {
        var subDepartments = _context.SubDepartments.Include(x => x.Department).ToList();

        var existingFile = new FileInfo(fileName);

        using var package = new ExcelPackage(existingFile);
        var legalActs = new List<LegalAct>(420);

        var worksheet = package.Workbook.Worksheets[0];
        for (var i = 3; i < worksheet.Dimension.Rows; i++)
        {
            DateTime.TryParseExact(worksheet.Cells[i, 6].Value.ToString().Replace(".", string.Empty)[..8],
                "ddMMyyyy", CultureInfo.GetCultureInfo("ru-RU"), DateTimeStyles.None, out var documentDate);
            DateTime.TryParseExact(worksheet.Cells[i, 7].Value.ToString().Replace(".", string.Empty)[..8],
                "ddMMyyyy", CultureInfo.GetCultureInfo("ru-RU"), DateTimeStyles.None, out var publishDate);

            var name = worksheet.Cells[i, 2].Value.ToString() ?? "";
            var legalActType = "";
            if(worksheet.Cells[i, 5].Value != null)
                legalActType = worksheet.Cells[i, 5].Value.ToString() ?? "";
            
            var legalAct = new LegalAct
            {
                LegalActTsVectorName = new LegalActTsVector {Name = name},
                Name = name, 
                DocumentDate = documentDate, 
                PublishDate = publishDate, 
                LegalActType = legalActType, 
                LegalActUrl = "",
            };

            if (worksheet.Cells[i, 4].Value != null)
            {
                var searchingDepartment = worksheet.Cells[i, 4].Value.ToString().ToLower().TrimEnd(' ');
                var subDepartment = subDepartments.FirstOrDefault(x =>
                    x.Name.ToLower().Contains(searchingDepartment) ||
                    x.Name.ToLower() == searchingDepartment ||
                    searchingDepartment.Contains(x.Name.ToLower()));

                if (subDepartment != null)
                {
                    legalAct.SubDepartment = subDepartment;
                    legalAct.Department = subDepartment.Department;
                }
            }

            if (legalAct.Department == null && worksheet.Cells[i, 3].Value != null)
            {
                var searchingDepartment = worksheet.Cells[i, 3].Value.ToString().ToLower().TrimEnd(' ');
                var department = subDepartments.FirstOrDefault(x => x.Department != null && (
                    x.Department.Name.ToLower().Contains(searchingDepartment) ||
                    x.Department.Name.ToLower() == searchingDepartment ||
                    x.Department.Abbreviation.ToLower().Contains(searchingDepartment) ||
                    x.Department.Abbreviation.ToLower() == searchingDepartment));
                if (department != null)
                {
                    legalAct.Department = department.Department;
                }
            }

            legalActs.Add(legalAct);
        }

        _context.LegalActs.AddRange(legalActs);
        _context.SaveChanges();
    }
}