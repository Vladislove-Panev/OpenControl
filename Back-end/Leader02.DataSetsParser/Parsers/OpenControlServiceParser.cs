using Leader.Domain.Entity;
using Leader02.Infrastructure;
using OfficeOpenXml;

namespace Leader02.DataSetsParser.Parsers;

public class OpenControlServiceParser
{
    private readonly Leader02Context _context;

    public OpenControlServiceParser(Leader02Context context)
    {
        _context = context;
    }

    public void OpenControlServiceParsing(string fileName)
    {
        var existingFile = new FileInfo(fileName);

        using var package = new ExcelPackage(existingFile);
        var openControlServices = new List<OpenControlService>(20);

        var worksheet = package.Workbook.Worksheets[0];
        for (var i = 2; i < 10; i++)
        {
            var openControlService = new OpenControlService
            {
                Description = worksheet.Cells[i, 3].Value.ToString() ?? "",
                Name = worksheet.Cells[i, 2].Value.ToString() ?? "",
                Number = int.Parse(worksheet.Cells[i, 1].Value.ToString()), 
                OpenControlServiceUrl = ""
            };

            openControlServices.Add(openControlService);
        }

        _context.OpenControlServices.AddRange(openControlServices);
        _context.SaveChanges();
    }
}