using System.Globalization;
using Leader.Domain.Entity;
using Leader02.Infrastructure;
using Microsoft.EntityFrameworkCore;
using OfficeOpenXml;

namespace Leader02.DataSetsParser.Parsers;

public class ConsultationTopicParser
{
    private readonly Leader02Context _context;

    public ConsultationTopicParser(Leader02Context context)
    {
        _context = context;
    }

    public void ConsultationTopicParsing(string fileName)
    {
        var subDepartments = _context.SubDepartments.Include(x => x.Department).ToList();
        var usedSubDepartments = new List<SubDepartment?>();

        var existingFile = new FileInfo(fileName);

        using var package = new ExcelPackage(existingFile);
        ExcelWorksheet? worksheet;

        worksheet = package.Workbook.Worksheets[1];

        usedSubDepartments.Clear();

        var consultationTopics = new List<ConsultationTopic>();

        for (var row = 2; row <= worksheet.Dimension.Rows; ++row)
        {
            var subDepartment = subDepartments.FirstOrDefault(x => x.Name == worksheet.Cells[row, 3].Value.ToString());

            consultationTopics.Add(new ConsultationTopic
            {
                SubDepartment = subDepartment, 
                Code = int.Parse(worksheet.Cells[row, 1].Value.ToString()), 
                Topic = worksheet.Cells[row, 4].Value.ToString()
            });
        }

        _context.ConsultationTopics.AddRange(consultationTopics);
        _context.SaveChanges();
    }
}