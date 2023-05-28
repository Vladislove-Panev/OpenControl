using Leader02.Application.IServices;
using Microsoft.AspNetCore.Mvc;

namespace Leader02.Api.Controllers;

[ApiController]
[Route("[controller]")]
public class ConsultationSlotController : ControllerBase
{
    private readonly IConsultationSlotService _consultationSlotService;

    public ConsultationSlotController(IConsultationSlotService consultationSlotService)
    {
        _consultationSlotService = consultationSlotService;
    }
    
    [HttpGet("by-sub-department/{id:int}")]
    public async Task<IActionResult> GetBySubDepartmentId(int id, CancellationToken ct)
    {
        var consultationSlots = await _consultationSlotService.GetAllBySubDepartmentId(id, ct);
        return Ok(consultationSlots);
    }
}