using Leader.Domain.Entity;
using Leader02.Infrastructure;
using OfficeOpenXml;

namespace Leader02.DataSetsParser.Parsers;

public class DepartmentParser
{
    private readonly Leader02Context _context;

    public DepartmentParser(Leader02Context context)
    {
        _context = context;
    }

    public void DepartmentParsing(string fileName)
    {
        var existingFile = new FileInfo(fileName);

        using var package = new ExcelPackage(existingFile);
        var departments = new List<Department>(20);

        ExcelWorksheet? worksheet;
        for (var i = 1; i < package.Workbook.Worksheets.Count; i++)
        {
            worksheet = package.Workbook.Worksheets[i];

            var department = new Department
            {
                Abbreviation = worksheet.Name, 
                Description = "", 
                Name = worksheet.Cells[1, 1].Value.ToString() ?? "", 
                DepartmentUrl = "", 
                SubDepartments = new List<SubDepartment>()
            };

            for (var row = 2; row <= worksheet.Dimension.Rows; ++row)
            {
                if (worksheet.Cells[row, 1].Value != null && !string.IsNullOrEmpty(worksheet.Cells[row, 1].Value.ToString()))
                {
                    department.SubDepartments.Add(new SubDepartment
                    {
                        SubDepartmentTsVector = new SubDepartmentTsVector
                        {
                            Description = department.Abbreviation + " " + department.Name + " " + department.Description + " " + worksheet.Cells[row, 1].Value
                        }, 
                        Name = worksheet.Cells[row, 1].Value.ToString() ?? "", 
                        SubDepartmentDescription = "", 
                        SubDepartmentUrl = ""
                    });
                }
                else
                {
                    break;
                }
            }

            departments.Add(department);
        }

        _context.Departments.AddRange(departments);
        _context.SaveChanges();
    }
}