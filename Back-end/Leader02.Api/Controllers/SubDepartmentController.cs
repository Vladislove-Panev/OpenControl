using Leader02.Application.IServices;
using Microsoft.AspNetCore.Mvc;

namespace Leader02.Api.Controllers;

[ApiController]
[Route("[controller]")]
public class SubDepartmentController : ControllerBase
{
    private readonly ISubDepartmentService _subDepartmentService;

    public SubDepartmentController(ISubDepartmentService subDepartmentService)
    {
        _subDepartmentService = subDepartmentService;
    }
    
    [HttpGet("by-department/{id:int}")]
    public async Task<IActionResult> GetByDepartmentId(int id, CancellationToken ct)
    {
        var subDepartments = await _subDepartmentService.GetAllByDepartmentId(id, ct);
        return Ok(subDepartments);
    }
}