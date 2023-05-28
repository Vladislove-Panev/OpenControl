using System.Globalization;
using Leader.Domain.Entity;
using Leader02.Infrastructure;
using Microsoft.EntityFrameworkCore;
using OfficeOpenXml;

namespace Leader02.DataSetsParser.Parsers;

public class ConsultationSlotParser
{
    private readonly Leader02Context _context;

    public ConsultationSlotParser(Leader02Context context)
    {
        _context = context;
    }

    public void ConsultationSlotParsing(string fileName)
    {
        var subDepartments = _context.SubDepartments.Include(x => x.Department).ToList();
        var usedSubDepartments = new List<SubDepartment?>();

        var existingFile = new FileInfo(fileName);

        using var package = new ExcelPackage(existingFile);
        ExcelWorksheet? worksheet;

        for (var i = 1; i < package.Workbook.Worksheets.Count; i++)
        {
            worksheet = package.Workbook.Worksheets[i];
            
            usedSubDepartments.Clear();

            var consultationSlots = new List<ConsultationSlot>();

            var isSlot = false;
            for (var row = 2; row <= worksheet.Dimension.Rows; ++row)
            {
                if (isSlot)
                {
                    foreach (var usedSubDepartment in usedSubDepartments)
                    {
                        if (worksheet.Cells[row, 1].Value != null && !string.IsNullOrEmpty(worksheet.Cells[row, 1].Value.ToString()))
                        {
                            DateTime.TryParseExact(worksheet.Cells[row, 1].Value.ToString()?.Replace(".", string.Empty)[..8],
                                "ddMMyyyy", CultureInfo.GetCultureInfo("ru-RU"), DateTimeStyles.None, out var slotDate);
                            consultationSlots.Add(new ConsultationSlot
                            {
                                SubDepartment = usedSubDepartment, 
                                Status = 0, 
                                SlotDate = slotDate, 
                                SlotTime = worksheet.Cells[row, 2].Value.ToString(),
                                OtherInformation = string.Empty
                            });
                        }

                        if (worksheet.Cells[row, 4].Value != null && !string.IsNullOrEmpty(worksheet.Cells[row, 4].Value.ToString()))
                        {
                            DateTime.TryParseExact(worksheet.Cells[row, 4].Value.ToString()?.Replace(".", string.Empty)[..8],
                                "ddMMyyyy", CultureInfo.GetCultureInfo("ru-RU"), DateTimeStyles.None, out var slotDate);
                            consultationSlots.Add(new ConsultationSlot
                            {
                                SubDepartment = usedSubDepartment, 
                                Status = 0, 
                                SlotDate = slotDate, 
                                SlotTime = worksheet.Cells[row, 5].Value.ToString(),
                                OtherInformation = string.Empty
                            });
                        }

                        if (worksheet.Cells[row, 7].Value != null && !string.IsNullOrEmpty(worksheet.Cells[row, 7].Value.ToString()))
                        {
                            DateTime.TryParseExact(worksheet.Cells[row, 7].Value.ToString()?.Replace(".", string.Empty)[..8],
                                "ddMMyyyy", CultureInfo.GetCultureInfo("ru-RU"), DateTimeStyles.None, out var slotDate);
                            consultationSlots.Add(new ConsultationSlot
                            {
                                SubDepartment = usedSubDepartment, 
                                Status = 0, 
                                SlotDate = slotDate, 
                                SlotTime = worksheet.Cells[row, 8].Value.ToString(),
                                OtherInformation = string.Empty
                            });
                        }
                    }

                    continue;
                }

                if (worksheet.Cells[row, 1].Value != null && !string.IsNullOrEmpty(worksheet.Cells[row, 1].Value.ToString()))
                {
                    var usedSubDepartment = subDepartments.FirstOrDefault(x => x.Name == worksheet.Cells[row, 1].Value.ToString());
                    if(usedSubDepartment != null)
                        usedSubDepartments.Add(usedSubDepartment);
                }

                if (worksheet.Cells[row, 1].Value != null && worksheet.Cells[row, 1].Value.ToString() == "Июнь")
                {
                    isSlot = true;
                }
            }

            _context.ConsultationSlots.AddRange(consultationSlots);
            _context.SaveChanges();
        }
    }
}